Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6786511D84D
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 22:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfLLVI1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 16:08:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:59242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730812AbfLLVI0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Dec 2019 16:08:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D14CDAD95;
        Thu, 12 Dec 2019 21:08:24 +0000 (UTC)
Subject: Re: [RFC 04/25] spi: gpio: Implement LSB First bitbang support
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Murphy <dmurphy@ti.com>
References: <20191212033952.5967-1-afaerber@suse.de>
 <20191212033952.5967-5-afaerber@suse.de>
 <CAMuHMdWdxJ9AaWhyCW-u8fCpXSDCPd-D6Dx129SF5nRssZsK=g@mail.gmail.com>
 <9b4b6287-c1d9-1b41-88a8-7ac9fe222642@suse.de>
 <20191212171922.GM4310@sirena.org.uk>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <70bf4954-d7ab-e300-017c-c743a40162a4@suse.de>
Date:   Thu, 12 Dec 2019 22:08:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191212171922.GM4310@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 12.12.19 um 18:19 schrieb Mark Brown:
> On Thu, Dec 12, 2019 at 04:14:59PM +0100, Andreas Färber wrote:
>> Am 12.12.19 um 09:40 schrieb Geert Uytterhoeven:
>>> On Thu, Dec 12, 2019 at 4:41 AM Andreas Färber <afaerber@suse.de> wrote:
>>>> Add support for slave DT property spi-lsb-first, i.e., SPI_LSB_FIRST mode.
> 
>>>> Duplicate the inline helpers bitbang_txrx_be_cpha{0,1} as LE versions.
>>>> Make checkpatch.pl happy by changing "unsigned" to "unsigned int".
> 
> Separate patch for this?

For the checkpatch cleanup? Or helpers preparation vs. spi-gpio.c usage?

>> So from that angle I don't see a better way than either duplicating the
>> functions or using some macro magic to #include the header twice. If we
>> wanted to go down that path, we could probably de-duplicate the existing
>> two functions, too, but I was trying to err on the cautious side, since
>> I don't have setups to test all four code paths myself (and a ton of
>> more relevant but less fun patches to flush out ;)).
> 
> Yeah, I don't think there's any great options here with the potential
> performance issues - probably the nicest thing would be to autogenerate
> lots of variants but I think that's far more trouble than it's worth.

Maybe add another code comment to revisit that idea later then?

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
