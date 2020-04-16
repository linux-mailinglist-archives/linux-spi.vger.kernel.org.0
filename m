Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D24D1AC1E8
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 14:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894533AbgDPM63 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 16 Apr 2020 08:58:29 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:46790 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894447AbgDPM61 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 08:58:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DB4B227E0DCF;
        Thu, 16 Apr 2020 14:58:24 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DHH_5V3HGF-F; Thu, 16 Apr 2020 14:58:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id A277C27E0DD4;
        Thu, 16 Apr 2020 14:58:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zT3WScpoRkvn; Thu, 16 Apr 2020 14:58:24 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 8F92327E0DD2;
        Thu, 16 Apr 2020 14:58:24 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:58:24 +0200 (CEST)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalrayinc.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1262823717.15763605.1587041904410.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20200416124725.GI5354@sirena.org.uk>
References: <20200416110823.22565-1-cleger@kalray.eu> <20200416110916.22633-1-cleger@kalray.eu> <20200416110916.22633-2-cleger@kalray.eu> <20200416113539.GG5354@sirena.org.uk> <622416308.15749883.1587037855167.JavaMail.zimbra@kalray.eu> <20200416124725.GI5354@sirena.org.uk>
Subject: Re: [PATCH 2/2] spi: dw: remove cs_control and poll_mode members
 from chip_data
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3895)
Thread-Topic: remove cs_control and poll_mode members from chip_data
Thread-Index: u6+BzXYec9ZWEUrvuKhpkEo14J92aA==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



----- On 16 Apr, 2020, at 14:47, Mark Brown broonie@kernel.org wrote:

> On Thu, Apr 16, 2020 at 01:50:55PM +0200, Clément Leger wrote:
>> Hi Mark,
> 
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.

Sorry, I'll take care of that.

> 
>> Sorry, maybe the commit message was not clear enough but actually
>> these fields were not initialized so it does not break anything
>> (ie, the default values were always used).
> 
> When you remove the definition of the struct and declaration of the
> variable pointing to it then the code won't compile.

Yes I know and I took care of that but there is probably a misunderstanding.
There is actually two structs with the same members (dw_chip_info and
chip_data). The first one (chip_info) if it exists, is copied into the
second (chip_data). First patch [1/2] removes the part of code that did
copy these fields. And then second patchs removes the usage of chip_data
fields. Please let me know if I missed something. I tried to recompile it
and there is no build breakage.

Clément

> 
> > > This means that your first patch will break the build, to keep things
