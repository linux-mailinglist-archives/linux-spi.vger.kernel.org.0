Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E496513C6
	for <lists+linux-spi@lfdr.de>; Mon, 19 Dec 2022 21:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiLSUWO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Dec 2022 15:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiLSUWI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Dec 2022 15:22:08 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2FCD7
        for <linux-spi@vger.kernel.org>; Mon, 19 Dec 2022 12:22:04 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 20EDC1286;
        Mon, 19 Dec 2022 21:22:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1671481320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hs6jsj/nCoiTADG1DhXD6LNYZTa7mguFOj+0keyD9Xs=;
        b=SS5r81SUvbRshGS5KeKQuBX6uvZXe7R1ufjQzGWKRneV24DQzUnnExt/U/0GyWThIU31iR
        H6qocs0hzjB9uwk+pZdioKzSqcSqdX1ZXXnSeyHs+IjEbhl3jzswwYv+sUaHVBQYG3Jsb9
        uFlVs3r6H6b9GK/0vBwvt7CHLebbxKxee1DhxT5l92xm92yjEDh6OsZjUnvOavic9yW6VS
        naTzS71BAwGFNX4BYuTiAgE+dHf2CK5FAuLDkiKJjbIm2110sX5vt8Y/ff9nry0y7xoUFo
        gmgs0A3qEHg9ukw2BSmNBVpaLcGjSpZjcCnYwRFTSu05tptT05j9Jlm2PO3Enw==
MIME-Version: 1.0
Date:   Mon, 19 Dec 2022 21:21:59 +0100
From:   Michael Walle <michael@walle.cc>
To:     Han Xu <han.xu@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Bough Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: Re: DMA support for FlexSPI driver
In-Reply-To: <20221219200857.fckuqovt3xt5r352@umbrella>
References: <CAOMZO5A5MxbKCnaoRo-ax+doTcEbu+S-bGoxcmYrA=eO5ExT4g@mail.gmail.com>
 <20221219200857.fckuqovt3xt5r352@umbrella>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <7c42628489ab90b545a8d86ba2e46696@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[+ Frieder and Boris]

Hi,

Am 2022-12-19 21:09, schrieb Han Xu:
> On 22/12/19 02:08PM, Fabio Estevam wrote:
>> Hi,
>> 
>> Currently, there is no DMA support for the drivers/spi/spi-nxp-fspi.c 
>> driver.
>> 
>> Is there a technical reason that prevents DMA to be used on this
>> driver with the i.MX8MM?
>> 
>> Also checked the NXP vendor driver, but DMA support is also missing.
>> 
>> Does anyone know more about the reason for this?

flexspi is a copy of the spi-fsl-qspi driver and I'd say the
latter just got the basic operations polled IO or the memory
mapped access and nobody cared :)

> We are working on that, both flexspi driver and sdma driver need to be 
> updated,
> and will upstream all once done.

Are you also working on the DMA support for the layerscape
architecture which is using eDMA?

-michael
