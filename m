Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10BE4D6724
	for <lists+linux-spi@lfdr.de>; Fri, 11 Mar 2022 18:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiCKRHI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Mar 2022 12:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiCKRHH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Mar 2022 12:07:07 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CECA9954
        for <linux-spi@vger.kernel.org>; Fri, 11 Mar 2022 09:06:03 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l20so16062580lfg.12
        for <linux-spi@vger.kernel.org>; Fri, 11 Mar 2022 09:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2aDtzt7CPJr9qOT3rSv/Vnnb69TtrcL0aLs6lMBg+RQ=;
        b=fihSNRu/3B6xviVANjQXeWIgkl9rWuTxp2RY4naCEIHiEhHDQXPUACZvtMlbVYdWIq
         FkqQmZueWwuFdWSoyFknM+JLtSkytidZsvq0kqYeGdBcmK80l6I4k1gaf0nJBzLy+X67
         lniyOf7zhGdjLFpBXnGd9SLkjq+/O3gnX+JoTbjopDX48JaWDhJ+Jj1mso2YDmXp5Mv9
         2u73hGjscsoXhhqtJzCNTuPrQGG+X3KTguzrXFBuENH5+pYPJn7zRlVNVgp5M0OHwhPi
         SeaCIxMV0kPUyd81Vyj0YuLrS/CSzuWIwB9bxmMfIADO8AI3JTqSZf3iMf/IF9ZKfUXT
         LDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2aDtzt7CPJr9qOT3rSv/Vnnb69TtrcL0aLs6lMBg+RQ=;
        b=ms4iB6FUgFewkFTHgSOAmiCY1BW3ofnxjufakLr8cv7DPpiee9+4S1Q+rYnOMvPR1v
         ccgei5z1wDE+s60YJZumcrIM24SAF9Z6dZR0YD50ROjOAwqyDiqCmsmts4voyeATT/g9
         R3KcWe7N1Z2RRtLtou2IcWTWybsq+AcMbTWf5DD1DIEBxtrIc6sStBVkE8wsinvKgHxu
         nJc9c8M54qekn/Bqk0lwvakqVk2uyHA5Tb3VhpxfdVBseoVBdXaCqNZd7AG0HTEsM5xz
         hrs/n9RxCxCW78jqxHBPuwro7+4NFdoGCR6CjRLBvbb9GJ9wB5GyFD8mn7jEzA6Eziso
         9dug==
X-Gm-Message-State: AOAM530CMqJm5C02UDefJEKG2BlBe/07eLbZVL0IBRzZDawHOEUre9TK
        YHR3I2+582FFZrA/qEA8+VQ=
X-Google-Smtp-Source: ABdhPJy5bQ5UNhgWrHx5uPScEsFVjndYUE0tHclTWzsV0QdMPl0FgdupxiYVDWfEirJwlbxG2MlirA==
X-Received: by 2002:a05:6512:1513:b0:448:39c0:def0 with SMTP id bq19-20020a056512151300b0044839c0def0mr6595118lfb.469.1647018360058;
        Fri, 11 Mar 2022 09:06:00 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id y10-20020a2e9d4a000000b0024608dc3520sm1821954ljj.125.2022.03.11.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:05:59 -0800 (PST)
Date:   Fri, 11 Mar 2022 20:05:58 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: dw: assert reset before deasserting reset
Message-ID: <20220311170558.5bj4vwbalufpmc3f@mobilestation>
References: <20220301111715.3062886-1-Niklas.Cassel@wdc.com>
 <20220311142550.haw5jnrjycavr43m@mobilestation>
 <Yitv+tKTH2RpTV2K@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yitv+tKTH2RpTV2K@x1-carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 11, 2022 at 03:51:23PM +0000, Niklas Cassel wrote:
> On Fri, Mar 11, 2022 at 05:25:50PM +0300, Serge Semin wrote:
> > Hello Niklas
> 
> Hello Serge,
> 
> > 
> > On Tue, Mar 01, 2022 at 11:17:20AM +0000, Niklas Cassel wrote:
> > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > 
> > > Simply deasserting reset just ensures that the hardware is taken out of
> > > reset, if it was booted with the hardware reset asserted.
> > > 
> > > In order actually reset the SPI controller, we need to assert reset before
> > > deasserting.
> > > 
> > > By doing this, we ensure that the hardware is not in some bad state, and we
> > > ensure that the hardware registers get set to their reset default, clearing
> > > any setting set by e.g. a bootloader.
> > > 
> > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > ---
> > >  drivers/spi/spi-dw-mmio.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > > index 5101c4c6017b..eb1dacb45ca2 100644
> > > --- a/drivers/spi/spi-dw-mmio.c
> > > +++ b/drivers/spi/spi-dw-mmio.c
> > > @@ -289,6 +289,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
> > >  		ret = PTR_ERR(dwsmmio->rstc);
> > >  		goto out_clk;
> > >  	}
> > 
> > > +	reset_control_assert(dwsmmio->rstc);
> > > +	udelay(2);
> > 
> > Do we really need this? dw_spi_add_host() is doing a sort of soft reset
> > anyway by calling the dw_spi_hw_init() method. Do you have a real
> > platform, which requires to do a full hard-reset?
> 
> Does this solve a real problem that I've seen with the SPI controller?
> No.
> 

> Which register write in dw_spi_hw_init() is doing a soft reset?
> I assume that you mean one of the writes in dw_spi_reset_chip(),
> probably DW_SPI_SSIENR.
> I don't think us toggling this register will reset all registers
> to their reset default values.

Well, you are right it isn't a true soft reset, that's why I added
"sort of".) Anyway after calling that method the main DW SSI registers
are supposed to be in a known state. Of course it doesn't reset the
controller RTL logic, and some of the CSRs will still be left randomly
initialized in case of bootloader doings.

> 
> I think it is a good to start off with all registers in their
> default reset values.
> 
> Arguably, I think it looks wrong to see a reset_control_deassert()
> without any previous reset_control_assert().
> 
> Do a simple:
> git grep -C 10 reset_control_deassert drivers/spi/
> 
> And you see that most SPI drivers (and most other device drivers for
> that matter), usually assert reset before deasserting it, in order
> to ensure that a reset pulse is actually sent to the hardware.
> 
> Simply deasserting reset, will have the hardware in a "fresh" state
> if it was a cold boot (where reset is usually asserted until deasserted),
> but will not have the hardware in a "fresh" state if booted via a boot
> loader. This is an inconsistency, and could potentially lead to issues
> that are only noticed if booting via a bootloader.
> 

No objection then seeing Mark is also inclined to have a full
hard-reset cycle here too.

> > 
> > What about the self-reset based controllers?
> 
> Not sure what specific feature in the SPI controller you are
> referring to.

I am speaking about the reset-controller lines. They can be of two
types: manually asserted/de-asserted and self-deasserted. It's
platform-specific and mainly depends on the reset-controller
implementation.

Seeing you are adding a full-reset cycle anyway, I suggest to add a
support for the both types of reset. Like this:

#include <linux/delay.h>
...

ret = reset_control_assert(dwsmmio->rstc);
if (ret == -ENOTSUPP) {
	ret = reset_control_reset(dwsmmio->rstc);
} else if (!ret) {
	udelay(2);
	ret = reset_control_deassert(dwsmmio->rstc);
}
if (ret)
	goto out;

* Please don't forget to add the include line.

BTW, I just figured it out. There is some incoherency in the
cleanup-on-error path of the dw_spi_mmio_probe() method. If
devm_reset_control_get_optional_exclusive() fails to get reset-control
then pclk will be left enabled. At the same time if init_func() fails
then pm_runtime_disable() will be called with not having
pm_runtime_enable() executed yet. If I don't miss something could you
fix that too?

-Sergey

> 
> 
> Kind regards,
> Niklas
