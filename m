Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C581FAB97
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgFPIsq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 04:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPIsq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 04:48:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22925C05BD43
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 01:48:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c17so22502362lji.11
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ipHYXFOqffERLAkWwuOtk+o9S3yNKQi9t8BO6IegYw=;
        b=WSUKWNyBsTiYY5slf9hDlpguQTO0Qyd5dB9qjB1WepBgEaPQoXTaHZaXKUVMo6Oi4F
         aGjmSJvl7nMzVLgw/u99vKoKd2Fe6VDFPt9juJkiXl6jjJF5iiEcVc8tzk/HcMgO3pL2
         uHbBxoyPjYLo886DCNWrj7hD/hHoMOQqmPV8uUI7uAtPu7lTAK8ujVa2u62xMDI9Q27z
         Dtni8d5OONib/A72kHYkCmfN1HiIzbLvoKRa+/Pw6ia3UNUyNI2b5ZPv+cVT1CE1wiYt
         lCdsAz8GSc7dlplJCil7/xyub8QKi3m5g3/DSaXDroUvlDm2E5uS7Uv9l1zWUkfpk6oT
         Tt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ipHYXFOqffERLAkWwuOtk+o9S3yNKQi9t8BO6IegYw=;
        b=kc5ymLtJMnCqtrocm62mw0TRcXihZ+y48PH4wLe0wuQwfFH8vMcCybglaRUWIfmN7A
         1xGF7XeBk0CqU0xStGyAZz0WCeu3UBWxi0hBgZ8evEcEoSheif4Og+PzI9suHIjuc/9o
         72E5S9WoTe4Jpj8ugfFXoRwdfAqLfUyeCKLIFisvG/qZaWawJVBcBmMsdjn529xS6aMB
         xg0UfIydQEeX3UCHSw8IfPDFSIBPAEnvwMHDN2+QNnuYD/yfSKZGcyQ93O32lra2o4XU
         88vZxaBauWoxnVZRoQ14Mlk5Nui1KeBRpgUw3LSaRJy6816xB06QUR1lBUoqKkijmWd1
         choQ==
X-Gm-Message-State: AOAM530DpRfye9oeD1vbJN8dAkSoSZyG91jHDdNxUc1RT8n0ALZPquSH
        ZLFC6zZwupGKKMgCEYbgBtAtLQ==
X-Google-Smtp-Source: ABdhPJzmfLHcXjST968jjGhoEmB1nVpMhXqrSoYRuGCP77JYZvlHyvy42Y7YX4QACeuLi4NfPbxTMg==
X-Received: by 2002:a2e:b0c2:: with SMTP id g2mr951715ljl.241.1592297324606;
        Tue, 16 Jun 2020 01:48:44 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:416:ca24:55bc:10a5:e37e:1ad1? ([2a00:1fa0:416:ca24:55bc:10a5:e37e:1ad1])
        by smtp.gmail.com with ESMTPSA id 4sm4249421ljq.34.2020.06.16.01.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 01:48:44 -0700 (PDT)
Subject: Re: [PATCH v4] spi: add Renesas RPC-IF driver
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        Rob Herring <robh+dt@kernel.org>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com>
 <159226448570.27735.17453498854310254061.b4-ty@kernel.org>
 <6fd4533e-c548-5d14-2d21-96efa0c58a0b@cogentembedded.com>
 <20200616083856.GF4447@sirena.org.uk>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6730033e-c966-d465-9273-75137e7ccbcd@cogentembedded.com>
Date:   Tue, 16 Jun 2020 11:48:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616083856.GF4447@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16.06.2020 11:38, Mark Brown wrote:
> On Tue, Jun 16, 2020 at 11:24:55AM +0300, Sergei Shtylyov wrote:
>> On 16.06.2020 2:41, Mark Brown wrote:
> 
>>> All being well this means that it will be integrated into the linux-next
>>> tree (usually sometime in the next 24 hours) and sent to Linus during
>>> the next merge window (or sooner if it is a bug fix), however if
>>> problems are discovered then the patch may be dropped or reverted.
> 
>>     You realize that the SPI driver won't build alone, w/o the
>> drivers/memory/ core driver merged, right?
> 
> Those aren't merged yet?  There was no mention of any dependencies in

    No. I thought we had an agreement about this (core) driver going in thru
the SPI tree (because there's no repo for drivers/memory/ anyway). Looking
at the DT patchwork:

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/4becbd3b-c9b9-070a-5771-48cade6651e5@cogentembedded.com/

the DT bindings still need to be reviewed -- but by whom? The "Checks"
section indicates that they did pass the DT checks this time around).
Rob?

> the patch, no feedback for months on the patch and I've not seen any
> ongoing discussion.

    Everybody seems to be in a silent agreement. :-)

MBR, Sergei
