Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1C44DDCF9
	for <lists+linux-spi@lfdr.de>; Fri, 18 Mar 2022 16:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiCRPd2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Mar 2022 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiCRPcz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Mar 2022 11:32:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9A723F3C7
        for <linux-spi@vger.kernel.org>; Fri, 18 Mar 2022 08:31:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q11so7196999pln.11
        for <linux-spi@vger.kernel.org>; Fri, 18 Mar 2022 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YZDc1n1Qj1g+iYOlQ71R/QnMyeerP7vB3YlY2gtmVQs=;
        b=TO1dJFjplhLStEuldURPec3qGDKlIamsXAbMOZmKmL/R/nJFm7TfGUEExvIFdT/a5t
         XPMNDLF2SwNPowMCs5kWIZa9ugA0bVuuouNfvV5ioaKlgyYMEEbC6lyY5va2usn+8m84
         btyTt7HyPb3A0hJP0P5Dd43ODDMaUyw8YrzwcnocEZaL4eowAxrMKzkXYRDxAwJHm68o
         hxecDFRR9xR01p1iQAX9fucSwSOOlfU+5S0UaF1b9G4igcUT0Wx7I+ERVSZfFtpN74ZX
         DZsr/iVkULf+GnHSjt2Fo+nM11WsNgvHVuoUcpsyAmryP3lLOY5O6kITOiHXy4fLKPdy
         QCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YZDc1n1Qj1g+iYOlQ71R/QnMyeerP7vB3YlY2gtmVQs=;
        b=hIkgeqvnWBSGlz0V8XOpXcmIX7+pp/4gZnnByXyHMolsY45rJurDQFsjuQT2h2Bzyd
         I5LPixD/PkBKcOXLWIIsLLIc6G9KdCiq3HT4uWGwsDfSxH76uZDvetVFIYQIrp0s31L6
         69Bgq2RlBe89Tao3ROvzv5aYRLgPriFDauXOoAH/Fl9NjT1kJOG8DZni2xhcZrk3jYei
         rXMu5Rk26sTFuw06wVK58MYws46r3/XJZ+w/5F9kjjrEMoCB8yCLXMRN9XW1C9TNpEa5
         0hDmWI6piiCedu82FswMvR+tSYGZdmHeoYklUjegd03ZoUFKuniHyJyViK4kLRIWZbuu
         NSSQ==
X-Gm-Message-State: AOAM530TLC0bHzje8BMuRM1AKYViW2QCfBeWeN/Etqga/275k1Vrisxt
        9zVs0w8cDb8dUFsnlpGj5XM=
X-Google-Smtp-Source: ABdhPJxxYecAXXJGYrf9oIQKz0gMdN1nAGtiONhbJACeeYMCdpr7FsU242EwS0mhc2MYdo3aJB54dg==
X-Received: by 2002:a17:902:ce02:b0:151:a86d:dc2b with SMTP id k2-20020a170902ce0200b00151a86ddc2bmr10875065plg.57.1647617492693;
        Fri, 18 Mar 2022 08:31:32 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id il7-20020a17090b164700b001bfc017a0adsm13562267pjb.37.2022.03.18.08.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 08:31:32 -0700 (PDT)
Message-ID: <f3e046b0-9afa-c0dc-8e60-eb9723ecfc99@gmail.com>
Date:   Fri, 18 Mar 2022 08:31:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: bcm2711 / RPi4 not functional after d62069c22eda
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>,
        Miguel Angel Ajo <majopela@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-spi@vger.kernel.org
References: <CAC3B9fn9DWezr3rspLbomuRLtRjSvW89cLMWR9TTCYsX=PDM_w@mail.gmail.com>
 <CAC3B9fkpO13QhCgVO-qyynbwdh_z60CKgpUhn-40NyGNGz_q8Q@mail.gmail.com>
 <20220318125925.GA21543@wunner.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220318125925.GA21543@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 3/18/2022 5:59 AM, Lukas Wunner wrote:
> [cc += linux-spi; please do not write developers directly without cc'ing
> relevant lists]
> 
> On Fri, Mar 18, 2022 at 11:54:35AM +0100, Miguel Angel Ajo wrote:
>> On Fri, Mar 18, 2022 at 11:47 AM Miguel Angel Ajo <majopela@redhat.com>
>> wrote:
>>>      I wanted to share a regression found after commit:
>>>
>>> d62069c22eda spi: bcm2835: Remove shared interrupt support
> [...]
>>> After this commit I get:
>>>
>>> [root@rpi4-64 ~]# dmesg | grep spi
>>> [   18.781250] spi-bcm2835 fe204000.spi: could not register SPI
>>> controller: -517
>>> [   19.134138] spi-bcm2835 fe204000.spi: could not register SPI
>>> controller: -517
>>> [   19.895147] spi-bcm2835 fe204000.spi: could not register SPI
>>> controller: -517
>>> [   20.400137] spi-bcm2835 fe204000.spi: could not register SPI
>>> controller: -517
> 
> Those are transient errors, -517 is -EPROBE_DEFER.  Probing fails
> because a resource is not available (yet), to be retried again later
> if/when it becomes available.

You would want to check whether you have these two commits in your tree 
as well:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=266423e60ea1b953fcc0cd97f3dad85857e434d1
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8f24c58d1b69ecf410a673c22f546dc732bb879

or neither, because the first commit forces a lockstep update of the DTS.

The SPI driver does not uses that many shared resources besides 
interrupts, clocks and chip-select overs GPIOs, the first one is 
unlikely to be the problem, and so is the second, thus leaving the third 
resource as a candidate to defer on.

> 
> 
>>> ecfbd3c introduced support for the bcm2711 SoC that shares
>>> one interrupt over multiple spi controller instances.
>>>
>>> Do we have a more detailed description of the exact issue for
>>> which we reverted?, is there a plan to re-introduce the shared interrupt
>>> support while fixing the issue?
> 
> See here for why the commit was reverted:
> 
> https://lore.kernel.org/linux-spi/20200529174358.som3snunfxch6phi@wunner.de/
> 
> There was a second attempt to introduce shared interrupt support,
> but after a lengthy discussion, it was not pursued to fruition:
> 
> https://lore.kernel.org/linux-spi/20200604212819.715-1-f.fainelli@gmail.com/
> 
> So I believe shared interrupt support only exists in the Raspberry Pi
> Foundation's downstream kernel, but not yet in the mainline kernel.
> 
> Thanks,
> 
> Lukas

-- 
Florian
