Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE77017AAAC
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 17:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgCEQj6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 11:39:58 -0500
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:33138 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbgCEQj5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Mar 2020 11:39:57 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 661E9100E7B4B;
        Thu,  5 Mar 2020 16:39:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:966:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:2895:2915:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:4385:4605:5007:6691:7974:8957:10004:10226:10400:10848:11026:11232:11473:11658:11914:12043:12050:12297:12438:12663:12679:12740:12760:12895:13069:13132:13161:13229:13231:13311:13357:13439:14181:14659:14721:21080:21325:21433:21451:21627:21939:21984:30054:30069:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: joke94_3982612ce0113
X-Filterd-Recvd-Size: 2689
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Mar 2020 16:39:55 +0000 (UTC)
Message-ID: <e31a520573d20552223a16cf18be0674972a3fb2.camel@perches.com>
Subject: Re: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        John Garry <john.garry@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Date:   Thu, 05 Mar 2020 08:38:20 -0800
In-Reply-To: <15ad3c68-4e67-0c92-a0e1-c62861673561@infradead.org>
References: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
         <e265e7df-fd8c-691f-389a-c0e0e377ed9e@huawei.com>
         <84f8504924380fc6380216d03d28a2285e3d106e.camel@perches.com>
         <55edba5c-78d6-12e2-eff6-f16c204badee@huawei.com>
         <15ad3c68-4e67-0c92-a0e1-c62861673561@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2020-03-05 at 08:21 -0800, Randy Dunlap wrote:
> On 3/5/20 8:20 AM, John Garry wrote:
> > On 05/03/2020 16:01, Joe Perches wrote:
> > > On Thu, 2020-03-05 at 15:53 +0000, John Garry wrote:
> > > > On 05/03/2020 15:15, Joe Perches wrote:
> > > > > commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
> > > > > controller driver") likely inadvertently used a select statement
> > > > > with a CONFIG_ prefix, remove the prefix.
> > > > > 
> > > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > 
> > > > It's a pity checkpatch can't pick this stuff up...
> > > 
> > > You are free to write a rule and submit a patch.
> > > 
> > 
> > I'm not opposed to the idea...

It'd be better I think to update the grammar
verification in the tool that parses these files.

see: scripts/kconfig/...

> > > The grammar is pretty hard to verify from a patch
> > > fragment though.
> > > 
> > > There are 2 existing nominal false positives.
> > > 
> > > $ git grep 'select\b.*\bCONFIG_' -- '*/Kconfig*'
> > > drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
> > > drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
> > 
> > Ah, that's in the help text. I guess that those can be ignored simply based on the indentation.

The grammar is per line whitespace independent, so not necessarily.

> > drivers/platform/chrome/Kconfig:        select CONFIG_MFD_CROS_EC_DEV
> > 
> > The 2nd looks like it's incorrect.
> 
> Yes, we just got a patch for that one today.

That's the reason I submitted this one.


