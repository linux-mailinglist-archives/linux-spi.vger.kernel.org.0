Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997261AD19C
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgDPU5r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 16:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727983AbgDPU5q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 16:57:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F7DC061A0C;
        Thu, 16 Apr 2020 13:57:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t40so74726pjb.3;
        Thu, 16 Apr 2020 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TNtymgelMHjhml+qA/oAJm07WSbpvlYGuT1mzCnMDgg=;
        b=ayhKZJgPfAUsy+NxCBOLT10/lrBp7RpEFcaf+X0NmYEasB5LQ13SaxT5zbcbD4fyLc
         ND2v8m/SyQNZbd0rwd6sRzxBsX08aMMPqNOgNn6HJ/4uwYH54kyTFIvLWdnw718KVM83
         fVsODNYExfqq/gbapOmpwHI/7jhMjTPHjupweONZhufpKfHPoQoP50fleMt57BgBxQZ6
         m44W7IYwOdaRqncCIhZiipSlxSwcOD53Fh47fC//MubmDqiITRieW39fJbHSzaqCjJDI
         NQO12pCMJ1V0z91z0M/8hDCBFvEMKfataNjTU2/ifkz8reB5jw4VdWhHNm/Nc223sYXs
         3TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TNtymgelMHjhml+qA/oAJm07WSbpvlYGuT1mzCnMDgg=;
        b=HK1KJVWBed2Nk/N3u8+/F3Ny8rZ0f0qKnIExNyIaYczNCo6aABjaQ/oVoR/3glPuAR
         yOr3rE8qdt1mu3wk37V5IQX+96CtfxDMwOqgVsmUlDO+dfLgusZijAndQ+v6g/w6qtnC
         BanNOjFTGjV8wAasKAIiz8JXiLlN1/cnsHsgWLh66HpmJByv21m20EJe2wDPP13yrBwe
         GlK9PTBXuPmp13ZreOnsA4i7QRWLmkHIM9m32kh8sAddCuTaQwuGsabXKjthKTR8eglY
         CeDt8NeZn0ThoLo2iD7kNIpsZYoqs4E0ZXa9yGQ5HUDhqg0IYL45yJHL9oeO857RYzjW
         ZYxQ==
X-Gm-Message-State: AGi0PuaVnoSSdYOtxHWoMPHe8A0ZPrXkOHLtNUV50Jd/xKchCP/o//uE
        FZRmlhgXtJ0ubS5pccusCQCodexN
X-Google-Smtp-Source: APiQypIL38pZGg7JnCN5MS/ZuZQ4eV/rE1irmJbknXe11DEeXh8574iGuykP4pbHnKVcWvQwEzLhtw==
X-Received: by 2002:a17:90b:94d:: with SMTP id dw13mr224466pjb.49.1587070665047;
        Thu, 16 Apr 2020 13:57:45 -0700 (PDT)
Received: from [10.230.188.26] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i190sm676747pfe.114.2020.04.16.13.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 13:57:44 -0700 (PDT)
Subject: Re: [Patch 9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only on
 legacy controllers
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
 <20200416174309.34044-9-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f7c2749c-9767-e0f0-ecc4-6582d0b5a9e6@gmail.com>
Date:   Thu, 16 Apr 2020 13:57:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416174309.34044-9-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 4/16/2020 10:43 AM, Kamal Dasu wrote:
> Set MASTER bit on the MSPI_SPCR0_MSB only for legacy MSPI and HIF_MSPI
> controllers.
> 
> refs #SWLINUX-5186

You will want to remove our internal tree reference here.
-- 
Florian
