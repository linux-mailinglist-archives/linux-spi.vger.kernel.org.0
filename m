Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2800F22EF8F
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 16:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgG0ORS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 10:17:18 -0400
Received: from smtprelay0005.hostedemail.com ([216.40.44.5]:50792 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731012AbgG0ORR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 10:17:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A86F2182CF670;
        Mon, 27 Jul 2020 14:17:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3874:4321:5007:7514:10004:10400:10848:11232:11658:11914:12295:12297:12555:12679:12740:12760:12895:13069:13095:13161:13181:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21212:21433:21451:21627:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: park62_3b1655626f61
X-Filterd-Recvd-Size: 2448
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Jul 2020 14:17:11 +0000 (UTC)
Message-ID: <a594ffa8112a9696260d8a01fa7941b125cf6226.camel@perches.com>
Subject: Re: [PATCH v2] spi: spi-topcliff-pch: drop call to wakeup-disable
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Date:   Mon, 27 Jul 2020 07:17:10 -0700
In-Reply-To: <CAHp75Vfuw1rAYxy41hVKNaqZQg4W-_Y=6St-X0yb5O4zN6qCfw@mail.gmail.com>
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
         <20200727131742.82289-1-vaibhavgupta40@gmail.com>
         <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com>
         <20200727134646.GA114726@gmail.com>
         <CAHp75Vfuw1rAYxy41hVKNaqZQg4W-_Y=6St-X0yb5O4zN6qCfw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2020-07-27 at 17:08 +0300, Andy Shevchenko wrote:
> Joe, can we amend checkpatch to at least shout about simple typos in
> the tag area?
> See below for the context.
> 
> On Mon, Jul 27, 2020 at 4:48 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> > On Mon, Jul 27, 2020 at 04:38:40PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 27, 2020 at 4:21 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> 
> ...
> 
> > > > Fix: f185bcc77980("spi: spi-topcliff-pch: use generic power management")
> > > 
> > > Fixes: and missed space.
> 
> (1)
> 
> > > > Reported by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > 
> > > Missed dash.
> > > Does checkpatch complain?
> > No, I got this message:
> > "* .patch has no obvious style problems and is ready for submission"
> 
> (2)

Not reasonably so far as I can tell, no.

The test for a signature uses -by:

Fix: starting a line seems a reasonable thing
that someone might want to have in a commit
message.


