Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB721E78BE
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 10:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgE2Itb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgE2Ita (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 04:49:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B4BC08C5C6
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 01:49:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z6so1570687ljm.13
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1l4xtGOxhqqlxgIkGPyKhx55xNwxZ5usjoQR3ai/dCs=;
        b=kaFjl6haj8O8E8+DmE686PPUoSGeVZy1HTTpnNUDRBpxA/k+lKvri2wRisWgT2iT2y
         FVKLgHhA10JSdaHrsa+l2lQXc9FLLoHrOqQ0zr5/4PL+ZemuzIFMFMe7aYdCnLSIIH9w
         UuceE594b7VMWDsCtVStURZka3tsH9a4a64zzX9Cw2fizZalzwZnQhFwrnuGla08HZV+
         2TxIq4Zmk5oq2Y7/UPSUkPKe2A7rHEV7qxIuz2z7gS+xakAlKAsi/vqsq28SyAgPSHjF
         KqTlfO7kMhzOBOBgxvy4KyFKzshw/66MYuiLhXcsYo2Hds8lD9tN+I3Hdl3t3ORl9dOt
         a80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1l4xtGOxhqqlxgIkGPyKhx55xNwxZ5usjoQR3ai/dCs=;
        b=Wv/j6sJ70Fb3653TqNjzkUnp5ZSK5Jjm1WJfZrFCbcBrFcNZU42+8pcH9kN8qHh9QV
         bAAEe4yfIRhybD2HVtFNGhsSYIDu5vi+Ge9Fm1Kj9Lcc6Z5dk/StGbv1STa+dl5av0bx
         YV42Q0JLf0B4QviLgP4LtzohUX3Oj7QrAcmuF06KEjtfp86as6hr2WgGIbx332uV8o6q
         HrxeehNDCko1ibD0SQlbKkqD1io8QHXQLPiMVhMCFcj5/8jYY1seKLJE6PSzDy4VJ2Le
         3FsY4D34vVAYkDrF2AohS/++toUOeJlUttc6zCMr+QhOXmFXXyxQZSkimKtMnwsDAyrn
         tb6w==
X-Gm-Message-State: AOAM5316m8Jm+lvY9/VOA57nc6JPhwW59g/GwJ9ak7s4iqFqJ0RU7hhe
        uuH4Oanq2xAb3J+k7AITOANpow==
X-Google-Smtp-Source: ABdhPJzXUde5z0UiZwHiMG/jkD4n9ZihV6t4jN0gXDun6HT126YSr0NDTPIAn28I3N14iaTVHdMcYg==
X-Received: by 2002:a2e:7f08:: with SMTP id a8mr3840705ljd.332.1590742168088;
        Fri, 29 May 2020 01:49:28 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:2d5:373e:50fc:221d:1226:f18a? ([2a00:1fa0:2d5:373e:50fc:221d:1226:f18a])
        by smtp.gmail.com with ESMTPSA id l16sm2119454lfg.2.2020.05.29.01.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 01:49:27 -0700 (PDT)
Subject: Re: [PATCH v5 01/16] spi: dw: Set xfer effective_speed_hz
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
 <20200529035915.20790-2-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <afdf414a-df95-b130-85e8-cda5bf4e9405@cogentembedded.com>
Date:   Fri, 29 May 2020 11:49:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529035915.20790-2-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 29.05.2020 6:58, Serge Semin wrote:

> Seeing DW APB SSI controller doesn't support setting the exactly
> requested SPI bus frequency, but only a rounded frequency determined
> by means of the odd-numbered half-worded reference clock divider,
> it would be good tune the SPI core up and initialize the current
                   ^ to?

> transfer effective_speed_hz. By doing so the core will be able to
> execute the xfer-related delays with better accuracy.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
[...]

MBR, Sergei
