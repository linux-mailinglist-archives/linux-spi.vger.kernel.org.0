Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD81E1FD9
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbgEZKiH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 06:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgEZKiG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 May 2020 06:38:06 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C4C03E97E;
        Tue, 26 May 2020 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DcCPTegeL4/9yo2vCU/JGoVKdudEoFYRZ1hgMcX0JO0=; b=qhIXUq65KKmkwLWRnRnI9CLOIS
        rD3r9RUkwcBrzCVqh8UlmI4LPMGuYe0mhot5T8qAOpfEpmpCQmJt5AMH+nKfagIPpkJRMleng1mxz
        OyTK+NFKACihHd75NOPNlfEPWMGrMNPGsC1CL0dV/C0BrRk4VRNMqcAb0Anc8TK6hbWNnDiue89PQ
        VT5+lRx38B/PrsaAuVranD0BLfTnG7SmrJxOOM7zDIHSsL7XlSdPJ4LJ5kMngek2ugR4+s3p7omsh
        BmQoIVwFO4bL2f0m9dY/lEGh6ygghp/tRCaOp54B/zfoU6JcRyRvvI0pYLHODI1ez2TMXOONr8GyV
        fwZhjEgQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58843 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1jdWyA-00012X-Db; Tue, 26 May 2020 12:38:02 +0200
Subject: Re: [PATCH v5 6/8] drm/panel: Add ilitek ili9341 panel driver
To:     dillon min <dillon.minfei@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
 <1590378348-8115-7-git-send-email-dillon.minfei@gmail.com>
 <CAHp75VebSZa6mwAETnM0t42RQCp4iM6_SNjmy3TB48ixsGKV8g@mail.gmail.com>
 <CAL9mu0+jmcivC6zAXxK0-oXy3n44pAU1QGD7BDq=CT2D7twROQ@mail.gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <c085e8f5-f626-28a9-1d3f-a1c277ec5052@tronnes.org>
Date:   Tue, 26 May 2020 12:38:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL9mu0+jmcivC6zAXxK0-oXy3n44pAU1QGD7BDq=CT2D7twROQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Den 26.05.2020 11.08, skrev dillon min:
> Hi Andy,
> 
> Thanks for input.
> 
> On Tue, May 26, 2020 at 3:46 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Mon, May 25, 2020 at 6:46 AM <dillon.minfei@gmail.com> wrote:
>>>
>>> From: dillon min <dillon.minfei@gmail.com>
>>>
>>>     This driver combine tiny/ili9341.c mipi_dbi_interface driver
>>>     with mipi_dpi_interface driver, can support ili9341 with serial
>>>     mode or parallel rgb interface mode by register configuration.
>>
>> Noralf told once that this driver should be unified with mi0283qt.c.
>>
>> So, what should we do here?
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
> 
> from sam's suggestion, we can't setup two drivers to support one panel
> in the tree. so, i copy the mipi dbi part from tiny/ili9341.c. to this driver
> from register settings and dts binding is keep the same to tiny/ili9341.c.
> 
> so, in my opinion if tiny/ili9341.c is unified with mi0283qt.c, this
> driver should be
> too.
> 

There's a discussion about MIPI DBI panels here:

MIPI DSI, DBI, and tinydrm drivers
https://lists.freedesktop.org/archives/dri-devel/2020-May/267031.html

Noralf.

> thanks.
> 
> best regards,
> 
> Dillon,
> 
