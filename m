Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC362444F2
	for <lists+linux-spi@lfdr.de>; Fri, 14 Aug 2020 08:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgHNGTl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Aug 2020 02:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgHNGTk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Aug 2020 02:19:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6855C061757;
        Thu, 13 Aug 2020 23:19:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m20so6017961eds.2;
        Thu, 13 Aug 2020 23:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UXT1flf+cw02X+05sr2H1r1+otkr90aq0IsOI5+Wa0I=;
        b=oJREn4cU3O1rw40AArW6Z81miwvHWgeTAeOuCZwcGRdzjwbMGlJiJzVMO6kHSg92KQ
         +X3lAjCIy6el5qQZmr/wcM3uyTXrttad09f+difG5wi9uxZl5UZUkeQoS260D+M2ymVJ
         lAwxngVc3XRwsSfDD/5nIAJqN0lkxSRqlO63r0+/7qeshTgU3p3RRj4FzFWhdLJxnqjx
         nKKJfIzbXEqoq3OPg6tfkSG3P0YW0prIvDSDfRW37ayGp+zoEZkCfwK90yCh/lRaZ+og
         ADUpw1j3AwXS147XD7x61UHTIwJDq7A/c9aO2aWzY34veRUFr/Jb4ulLjIfYQStydsYM
         dlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UXT1flf+cw02X+05sr2H1r1+otkr90aq0IsOI5+Wa0I=;
        b=E690AmMUj1+jx6oZ5XVsd7x4mWYPdax/wuzhiy2FqUH0bzTm4cmFE8ZHhjFzZgP7Et
         5+0VRMPClL9fGppWgH7pQkdA7eZiv5RLOvC/+G9+KTPfEjE2+GXC9Qbx7Eu9XPYNisQ5
         tOhZJ6TNAkwe6JsNDM6QkGLuctjUIti6zageWnNv+Lg2UJQ5QhZm+Md+t2z9xJLmqoxM
         zDNGvy5joQ2zJ7nQhvtk+/uuwPGjjon5i25PXrBAV4GzHXqlgCCtoFomQph3LSztVQOJ
         Qs9unniq93kGME8c27La8JAW4iUJqVXNGAcCDov9bzxuKXQkfC/f45f7X6GufgmHhJdM
         UhOg==
X-Gm-Message-State: AOAM530vrLStXSkmN3XuTeHs0Q5TOPuP1/3fg8e10x0GektY1QEJh1K6
        Ay2FGGLdpSgjRTfhiXaCv5Ufuq5wEbQH7A==
X-Google-Smtp-Source: ABdhPJz5pfQrOZ4FllnHVJ9ZLobKzbFsyza5qcMiYnCr5rzk+hPcTwUMgR05Pc/ScRwSaincGS2+yQ==
X-Received: by 2002:a05:6402:16:: with SMTP id d22mr860616edu.175.1597385978107;
        Thu, 13 Aug 2020 23:19:38 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:10c4:47b:9d52:cd78? (p200300ea8f23570010c4047b9d52cd78.dip0.t-ipconnect.de. [2003:ea:8f23:5700:10c4:47b:9d52:cd78])
        by smtp.googlemail.com with ESMTPSA id d9sm4979917edt.20.2020.08.13.23.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 23:19:37 -0700 (PDT)
Subject: Re: fsl_espi errors on v5.7.15
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "tiago.brusamarello@datacom.ind.br" 
        <tiago.brusamarello@datacom.ind.br>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3f48e5fb-33c9-8046-0f80-236eed163c16@alliedtelesis.co.nz>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <c43a23bd-33ec-4ef2-2ca5-730342248db3@gmail.com>
Date:   Fri, 14 Aug 2020 08:19:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3f48e5fb-33c9-8046-0f80-236eed163c16@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 14.08.2020 04:48, Chris Packham wrote:
> Hi,
> 
> I'm seeing a problem with accessing spi-nor after upgrading a T2081 
> based system to linux v5.7.15
> 
> For this board u-boot and the u-boot environment live on spi-nor.
> 
> When I use fw_setenv from userspace I get the following kernel logs
> 
> # fw_setenv foo=1
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
> ...
> 

This error reporting doesn't exist yet in 4.4. So you may have an issue
under 4.4 too, it's just not reported.
Did you verify that under 4.4 fw_setenv actually has an effect?

> If I run fw_printenv (before getting it into a bad state) it is able to 
> display the content of the boards u-boot environment.
> 

This might indicate an issue with spi being locked. I've seen related
questions, just use the search engine of your choice and check for
fw_setenv and locked.

> If been unsuccessful in producing a setup for bisecting the issue. I do 
> know the issue doesn't occur on the old 4.4.x based kernel but that's 
> probably not much help.
> 
> Any pointers on what the issue (and/or solution) might be.
> 
> Thanks,
> Chris
> 

Heiner
