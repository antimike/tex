% vim: syntax=tex
% vim: filetype=tex

%% TODO: Write .dtx documentation file

\NeedsTeXFormat{LaTeX2e}			%% Some expl3 macros are used, but are imported through packages
\ProvidesClass{pset}[2020/06/15 Template for physics problem sets.]

%% Most of the time, this package will be used with include.sty, so some of these
%% are redundant.  NBD
%% THE ORDER MATTERS SO DON'T FUCK WITH IT
\LoadClass{article}
\RequirePackage{fancyhdr}
\RequirePackage{xparse}
\RequirePackage{mdframed}
\RequirePackage{listofitems}
\RequirePackage{intcalc}
\RequirePackage{xifthen}
\RequirePackage{geometry}
\RequirePackage{titling}
\RequirePackage{amsthm}
\RequirePackage{amsmath}
\RequirePackage{mathtools}


%% Not sure yet what to do about the "geometry" setters below
%\setlength{\textwidth}{\paperwidth}
%\addtolength{\textwidth}{-2in}
%\calclayout

\geometry{lmargin=.75in, rmargin=.75in}


%% Layout environments and macros
\makeatletter								%% To allow use of "private" variables, TeX-style

\newcounter{problem}						%% Tracks the problem number
\newcounter{problempart}					%% Tracks which part of the problem we're on
\renewcommand\theproblempart{(\alph{problempart})}
\newcounter{problemstart}					%% Tracks which page the problem starts on

\setcounter{problem}{0}
\setcounter{problemstart}{1}	

%% Commands used to track display properties associated with individual problems
%% Not defined as "hidden" (i.e., using @ symbol) because there are limited use-cases
%% in which these might need to be accessible from an ordinary .tex file.
\newcommand{\theheadertitle}{}
\newcommand{\theproblemtitle}{}
\newcommand{\theproblemsubtitle}{}
\newcommand{\theproblemformattedtitle}{}
\newcommand{\usecustomppartlist}{\BooleanFalse}
\newcommand{\problempartlist}{}
\newcommand{\problempartformatkey}{a}
\newcommand{\theproblempartformattedname}{}
\newcommand{\theproblempartname}{}
\newcommand{\theproblemheadertext}{}
\newcommand{\theproblempage}{\the\numexpr\thepage-\theproblemstart+1\relax}
	%% Implements simple, "old-fashioned TeX"-style arithmetic to calculate how many pages 
	%% we've been working on this problem for
	
\newcommand{\defaultppartlist}{
	a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
}

\newcommand{\formatproblempartname}[1]{\fbox{\textbf{(#1)}} \quad}

%% Hacky implementation of "switch" statement
\newcommand{\ifequals}[3]{\ifthenelse{\equal{#1}{#2}}{#3}{}}
\newcommand{\case}[2]{#1 #2} % Dummy, so \renewcommand has something to overwrite...
\newenvironment{switch}[1]{\renewcommand{\case}{\ifequals{#1}}}{}

%% Formats problem part name based on "format key"
\newcommand{\getppartname}[1]
{\begin{switch}{#1}\case{a}{\alph{problempart}}\case{A}{\Alph{problempart}}\case{i}{\roman{problempart}}\case{I}{\Roman{problempart}}\case{1}{\arabic{problempart}}\end{switch}}


\NewDocumentEnvironment{problem}{ o o O{a} e{^} }
{
	\refstepcounter{problem}				%% Increments "problem" counter
	\setcounter{problemstart}{\thepage}		%% Initializes problemstart page counter
	\setcounter{problempart}{0}				%% Initializes "problempart" numerical counter
	\IfNoValueTF{#4}
		{
			\renewcommand{\usecustomppartlist}{\BooleanFalse}
			\renewcommand{\problempartformatkey}{#3}
			\readlist\problempartlist{\defaultppartlist}
		}
		{
			\renewcommand{\usecustomppartlist}{\BooleanTrue}
			\readlist\problempartlist{#4}
		}
	\IfNoValueTF{#1}						%% Set title based on 1st optional arg
		{\renewcommand{\theproblemtitle}{Problem \theproblem}}
		{\renewcommand{\theproblemtitle}{#1}}	
	\IfNoValueTF{#2}						%% Set subtitle based on 2nd optional arg
		{
			\renewcommand{\theproblemsubtitle}{}
			\renewcommand{\theproblemformattedtitle}{\textbf{\theproblemtitle}}%
		}
		{
			\renewcommand{\theproblemsubtitle}{#2}
			\renewcommand{\theproblemformattedtitle}{\textbf{\theproblemtitle} (\theproblemsubtitle)}
		}	
	\renewcommand{\theproblemheadertext}{\theproblemtitle \, -- \, \theproblempage}
	
%	\protected@edef\@currentlabelname{\theproblemtitle}
%% Not sure what this line was supposed to accomplish

	%% Format problem "title bar"
	\noindent \hrule height .5pt width \textwidth
	\vskip .75em
	\begin{center}
		\large{\theproblemformattedtitle}
	\end{center}
	\noindent \hrule height .5pt width \textwidth
	\vskip .75em
}{	\clearpage }

%% TODO: This command is broken.  Review the commented-out code to figure out why.
\NewDocumentCommand{\problempart}{}
{
	\refstepcounter{problempart}
	%\IfBooleanTF{\usecustomppartlist}
		%{
			%\renewcommand{\theproblempartname}{\problempartlist[\intcalcMod{\value{problempart} - 1}{\problempartlistlen} + 1]}		
		%}
		%{
			%\renewcommand{\theproblempartname}{\getppartname{\problempartformatkey}}
		%}
	\renewcommand{\theproblempartname}{\getppartname{\problempartformatkey}}
  %TODO: Figure out how to define \theproblempart macro to allow properly-formatted references using autoref / nameref
  %\renewcommand*{\theproblempart}{\theproblempartname}
	\vskip .75em \par
	\formatproblempartname{\theproblempartname}
}


%% Definition of the "problemstatement" environment.
%% Options:
%% 1. Text to appear at top of "problemstatement" box (optional; default is "Problem Statement")
%% 2. Text option (optional; default is \itshape to give italicized text)
%% 3. Background color of problemstatement text box (optional; default is "lightgray")
\NewDocumentEnvironment{problemstatement}{ O{Problem Statement} O{\itshape} O{lightgray} }%
{
	\begin{mdframed}[backgroundcolor=#3, frametitle={#1}]#2
}{	\end{mdframed}}

\makeatother

\NewDocumentCommand{\psettitle}{ m o }{
  \title{#1}
  \headertitle{#2}
}

\newcommand{\headertitle}[1]{\renewcommand{\theheadertitle}{#1}}
\numberwithin{equation}{problem}

%% Autoref stuff
\providecommand{\includegraphicsautorefname}{Figure}
\providecommand{\figureautorefname}{Figure}
\providecommand{\problemautorefname}{Problem}
\providecommand{\problempartautorefname}{Part}

%% Describe layout of title
\pretitle{
  \begin{center}
    \Large\bfseries
}
\posttitle{
  \end{center}
%  \noindent\vrule height 2.5pt width \textwidth
}
\preauthor{
  \begin{center}
  \begin{tabular}[t]{@{}l@{}}%
}
\postauthor{
    \end{tabular}
    \vskip -.5em
    \par
  \end{center}
}
\predate{
  \begin{center}
}
\postdate{
  \end{center}
}

%% Use fancyhdr package to set default header / footer text
\pagestyle{fancy}
\fancyhf{}
\fancyhf[lf]{\thedate{}}
\fancyhf[rf]{\thepage}
\fancyhf[lh]{\theheadertitle}
\fancyhf[ch]{\theproblemheadertext}
\fancyhf[rh]{\theauthor}
\setlength{\footskip}{30pt}
\renewcommand{\footrulewidth}{.4pt}
\renewcommand{\footrule}{\hrule height \footrulewidth width \textwidth}

%% Properly format references to items in lists
\providecommand{\itemautorefname}{}

%% Theorem environments
\newtheorem{theorem}{Theorem}[problem]
\providecommand{\theoremautorefname}{Theorem}
\newtheorem{proposition}{Proposition}[problem]
\providecommand{\propositionautorefname}{Proposition}
\newtheorem{corollary}{Corollary}[proposition]
\providecommand{\corollaryautorefname}{Corollary}
\theoremstyle{definition}
\newtheorem*{note}{Note}
\newtheorem*{todo}{TODO}
\newtheorem{definition*}{Definition}
\newtheorem{definition}{Definition}[problem]
\providecommand{\definitionautorefname}{Definition}
\newtheorem{example}{Example}[problem]
\providecommand{\exampleautorefname}{Example}
\theoremstyle{remark}
\newtheorem{remark}{Remark}[problem]
\providecommand{\remarkautorefname}{Remark}
