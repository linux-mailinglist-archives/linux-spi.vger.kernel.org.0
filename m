Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0048B4BB8B6
	for <lists+linux-spi@lfdr.de>; Fri, 18 Feb 2022 12:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiBRLyF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Feb 2022 06:54:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiBRLyF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Feb 2022 06:54:05 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C926B24CDF8
        for <linux-spi@vger.kernel.org>; Fri, 18 Feb 2022 03:53:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vz16so14584298ejb.0
        for <linux-spi@vger.kernel.org>; Fri, 18 Feb 2022 03:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PAFU6gayxYycFAjsYYdsBH4fb14B+9k5K1rC1fr5ibU=;
        b=y1ApFGs2wBKqI6YmqGjiKRoomFaWQn9GJ+esuDqvq1CBp+bPpXaaNWJxFaT95S6sQO
         nbB6NlB9oE/XYNfZ5GZGqFa1ulYJLqfN/+qUK4VZFEi8JQSmztrhJ5+iMlIvi6yW+JPj
         4fPTTTqHCCrzKTkp/QUn9I5U+wD1oSPiY08DcdkkFp5QNxU2ATqMGhNflB2g8QK1Mpi3
         zrM+ocM6Hvet65ejBI8tO8ffQ5j6KWZPkiPfFtTCywS5Kup/tbAlm2BHDqnGEZHS6HwZ
         DORXagahzNdE99rrzWxALDbyqxmTh/UcgIXyD24Lg2PYuGbeYTy037/J+Oq5S0w06VJK
         mj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PAFU6gayxYycFAjsYYdsBH4fb14B+9k5K1rC1fr5ibU=;
        b=SW6/FmRzJO/d0IhyiYZXRsFx8KYfxPQEg58u9Cev+GQPFlgdSoEX9nfQnP9AJkgQAi
         3fhe34RfXk7HdCw0lIgeixid+H/w4Gt+NRx51WhTnnIhgYy4bnPoFjNtCJqAvvaJ6+rN
         AzOPwTNSxZp+IqhG/YZ0NJpa0QokoQcG1qgZJhkj7TcHNYG/XRKOdTW06iT2M1lTZTIP
         CfvNtFD6POf3h7l1n7bUSMRtUW8hTrUr4Bwpnj0PbNbkfcMHZGHLawCxvNg44Dv1Jc18
         kWDf4YxVr4ZXM9isOGugcrX7CnAgJiCywAwRpYc5swLHuJ3dHgJksshf05r5VIVJXRml
         urMA==
X-Gm-Message-State: AOAM531jQ7EOjmSQDQVPqeIeGvtG20ydhPLgHwBW0IoMobpcZo1yHVms
        OR4fP+Ac5ClvEiNSGeBQxeinTFOaN7n6oA==
X-Google-Smtp-Source: ABdhPJzz58mhC9gqhYwFYu4oy6FCTDMQGTy6UF4AuD1gK4uU6HBfQlrpYujnCiE43A0uNYbiJHFm/A==
X-Received: by 2002:a17:906:5a6e:b0:6d0:afaa:6ce9 with SMTP id my46-20020a1709065a6e00b006d0afaa6ce9mr1219253ejc.72.1645185226330;
        Fri, 18 Feb 2022 03:53:46 -0800 (PST)
Received: from ?IPV6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id m7sm2203683ejq.10.2022.02.18.03.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 03:53:45 -0800 (PST)
Message-ID: <41049c30-aaf1-30e5-2d11-14df0b468411@monstr.eu>
Date:   Fri, 18 Feb 2022 12:53:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v6 0/3] Stacked/parallel memories bindings
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
References: <20220126112608.955728-1-miquel.raynal@bootlin.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <20220126112608.955728-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark

On 1/26/22 12:26, Miquel Raynal wrote:
> Hello Rob, Mark, Tudor & Pratyush,
> 
> Here is a sixth versions for these bindings, which applies on top of
> the v5.17-rc1 now that Pratyush's work as been merged.
> (https://lore.kernel.org/all/20211109181911.2251-1-p.yadav@ti.com/)
> 
> Cheers,
> Miquèl
> 
> Changes in v6:
> * Added Pratyush's acks.
> * The tooling now validates the binding (updating dt-schema is
>    necesary).
> * Updated the maxItems field to 4 as a "big enough value" as discussed.
> 
> Changes in v5:
> * Used the uint64-array instead of the matrix type.
> * Updated the example as well to use a single "/bits/ 64" cast because
>    doing it twice, despite being supported by the language itself, is not
>    yet something that we can use for describing bindings.
> 
> Changes in v4:
> * Changed the type of properties to uint64-arrays in order to be able to
>    describe the size of each element in the array.
> * Updated the example accordingly.
> 
> Changes in v3:
> * Rebased on top of Pratyush's recent changes.
> * Dropped the commit allowing to provide two reg entries on the node
>    name.
> * Dropped the commit referencing spi-controller.yaml from
>    jedec,spi-nor.yaml, now replaced by spi-peripheral-props.yaml and
>    already done in Pratyush's series.
> * Added Rob's Ack.
> * Enhanced a commit message.
> * Moved the new properties to the new SPI peripheral binding file.
> 
> Changes in v2:
> * Dropped the dtc changes for now.
> * Moved the properties in the device's nodes, not the controller's.
> * Dropped the useless #address-cells change.
> * Added a missing "minItems".
> * Moved the new properties in the spi-controller.yaml file.
> * Added an example using two stacked memories in the
>    spi-controller.yaml file.
> * Renamed the properties to drop the Xilinx prefix.
> * Added a patch to fix the spi-nor jedec yaml file.
> 
> Miquel Raynal (3):
>    dt-bindings: mtd: spi-nor: Allow two CS per device
>    spi: dt-bindings: Describe stacked/parallel memories modes
>    spi: dt-bindings: Add an example with two stacked flashes
> 
>   .../bindings/mtd/jedec,spi-nor.yaml           |  3 ++-
>   .../bindings/spi/spi-controller.yaml          |  7 ++++++
>   .../bindings/spi/spi-peripheral-props.yaml    | 25 +++++++++++++++++++
>   3 files changed, 34 insertions(+), 1 deletion(-)
> 

Can you please pick up this series?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


