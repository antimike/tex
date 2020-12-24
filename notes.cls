% vim: syntax=tex
% vim: filetype=tex

%% TODO: Write .dtx documentation file

\NeedsTeXFormat{LaTeX2e}			%% Some expl3 macros are used, but are imported through packages
\ProvidesClass{notes}[2020/10/26 Template for physics notes.]

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

\geometry{lmargin=.75in, rmargin=.75in}


%% Layout environments and macros
\makeatletter								%% To allow use of "private" variables, TeX-style
\newcommand{\theheadertitle}{}
\newcommand{\headertitle}[1]{\renewcommand{\theheadertitle}{#1}}
%\newcommand{\formatproblempartname}[1]{\fbox{\textbf{(#1)}} \quad}

\NewDocumentCommand{\notestitle}{ m o }{
  \title{#1}
  \headertitle{#2}
}

\NewDocumentEnvironment{answer}{+b}{
  \begin{proof}[Answer]
    #1
}{\end{proof}}

%% Hacky implementation of "switch" statement
\newcommand{\ifequals}[3]{\ifthenelse{\equal{#1}{#2}}{#3}{}}
\newcommand{\case}[2]{#1 #2} % Dummy, so \renewcommand has something to overwrite...
\newenvironment{switch}[1]{\renewcommand{\case}{\ifequals{#1}}}{}

%% Definition of the "statement" environment.
%% Options:
%% 1. Text to appear at top of "statement" box (optional; default is "Statement")
%% 2. Text option (optional; default is \itshape to give italicized text)
%% 3. Background color of problemstatement text box (optional; default is "lightgray")
\NewDocumentEnvironment{statement}{ O{Statement} O{\itshape} O{lightgray} }%
{
	\begin{mdframed}[backgroundcolor=#3, frametitle={#1}]#2
}{	\end{mdframed}}

\makeatother

\numberwithin{equation}{section}

%% Autoref stuff
\providecommand{\includegraphicsautorefname}{Figure}
\providecommand{\figureautorefname}{Figure}
\providecommand{\sectionautorefname}{Section}

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
\fancyhf[ch]{\leftmark}
\fancyhf[rh]{\theauthor}
\setlength{\footskip}{30pt}
\renewcommand{\footrulewidth}{.4pt}
\renewcommand{\footrule}{\hrule height \footrulewidth width \textwidth}

%% Properly format references to items in lists
\providecommand{\itemautorefname}{}
%\crefname{enumi}{}{}

%% Theorem environments
\newtheorem{theorem}{Theorem}[section]
\providecommand{\theoremautorefname}{Theorem}
\newtheorem{proposition}{Proposition}[section]
\providecommand{\propositionautorefname}{Proposition}
\newtheorem{corollary}{Corollary}[proposition]
\providecommand{\corollaryautorefname}{Corollary}
\theoremstyle{definition}
\newtheorem*{note}{Note}
\newtheorem*{todo}{TODO}
\newtheorem{definition*}{Definition}
\newtheorem{definition}{Definition}[section]
\providecommand{\definitionautorefname}{Definition}
\newtheorem{example}{Example}[section]
\providecommand{\exampleautorefname}{Example}
\newtheorem*{solution}{Solution}
\newtheorem{question}{Question}[section]
\providecommand{\questionautorefname}{Question}
\theoremstyle{remark}
\newtheorem{remark}{Remark}[section]
\providecommand{\remarkautorefname}{Remark}
