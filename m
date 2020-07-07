Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE17216995
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGJzw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgGGJzv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jul 2020 05:55:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CACC061755
        for <linux-spi@vger.kernel.org>; Tue,  7 Jul 2020 02:55:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so36649920edy.1
        for <linux-spi@vger.kernel.org>; Tue, 07 Jul 2020 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/Ez/eNUFPCT1S8lswjEFBXmdJUzvT2sdIqH6wPm0/aY=;
        b=QYe04Gp38RAEy6yPyNS14pK+XfQocLSDgJ5LEkRhAj7ABmY3kR3xx8qgc+u4Ry9uLZ
         k7KwDZbKVUaqCo7UyJxkZneDWHjo4VIi7Myp8O0I5c2pu5SepM0Fi0OuDMrFOvYOQ0zT
         MgkmuHp7x/wQGhMI/BKXWZyEgvQkHoZv5AWHVx3EeycrVCA6X3+sxTqWjP31srbxOqA5
         yVtGbKBN4350Uuy3yZI1ZWcplnWdk0fBAZZ0ITq45nji+j8YX8rbkBvosF9UiyRasryu
         hUST3Iy0F6nQyiIDl+ApwQ9pnqe7sV14ch5qEgADgY8wf41L455jHEpu1Dsym4MX3hrF
         AZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/Ez/eNUFPCT1S8lswjEFBXmdJUzvT2sdIqH6wPm0/aY=;
        b=mvpJmaaPOlxLkxyYBm3tAdqmNh4/hDY4fal53268YEYP+SUy05inAJ1QtLb1EZ9CW0
         tTtlWPAtHwGtUt8hW5pkF+TMI6K9qPfLUOtzV+OtDCx/oHo0M47R9wnV2zfV71i5wEps
         dNoVOiBirN00XacaKiKZB19tcCNUkgOmi36ZS9Uc8hCmDA/bATDxS9+PBZ10/9uXvX+9
         NRRjigpaVD780YSIdYOfYUg+dIVvtlrpw+V5DFH1giy+UfGIt4tooxh2smPm1HZjsoaB
         gdo4LgV6V3MSZiYKKASxMDR6/5Rtb6e5cGdrI7B3ReQpuMGpcaLZ+b6G0Vgwqse0xvTX
         DfLg==
X-Gm-Message-State: AOAM533G4G03Y5mw0bKvMUcBpnWy8UK2S4MZkxS0oga09eMzwcycwNan
        YvrVd5tEz9/7rd5eGoqHjfog
X-Google-Smtp-Source: ABdhPJzYEcxxIS7vSz9rt0N2e7MfND9YJ80TBhiJ+JQGtUro+WBaNmFEN1hYulHOJD1yWqfwad40/A==
X-Received: by 2002:aa7:d50d:: with SMTP id y13mr60181703edq.230.1594115749762;
        Tue, 07 Jul 2020 02:55:49 -0700 (PDT)
Received: from [192.168.33.195] (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id z22sm25865328edx.72.2020.07.07.02.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 02:55:49 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
X-Google-Original-From: Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Add documentation for SPI daisy chain
 driver.
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202007040833.xIqR5rAw%lkp@intel.com>
 <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706092247.20740-2-adrian.fiergolski@fastree3d.com>
 <CAMuHMdW_aTKtrUnGqf3DB=fr0ZxTsjoEjMmwSpPqhwjs-Tz7ig@mail.gmail.com>
 <d80b1b85-ee23-3244-9bb0-876986f6ff17@fastree3d.com>
 <CAMuHMdUV_2DbbUqp+0=XARyLCwPya1RqFCrr6VoTJjVAZiKJzg@mail.gmail.com>
 <20200706162246.GC6176@sirena.org.uk>
Message-ID: <853fa4a4-ce2f-0503-2fe7-7b34b352b6e2@fastree3d.com>
Date:   Tue, 7 Jul 2020 11:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706162246.GC6176@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert and Mark,

Thank you for your comments. I will try to address them in the next replies.

On 06.07.2020 18:22, Mark Brown wrote:
> On Mon, Jul 06, 2020 at 05:32:51PM +0200, Geert Uytterhoeven wrote:
>
>> However, that information would need to be added to each driver only once.
>> With your proposal, it has to be added to all affected nodes of all DTSes
>> of all users.
> Right, these are fixed properties of the silicon which we know simply
> from knowing which device we have - there is no need to put them in DT
> at all.

I see. I agree with you. My concern was just the lack of compatibility
with the existing drivers. I will try to add daisy_chain information to
spi_driver struct in version v3 of the patch.

