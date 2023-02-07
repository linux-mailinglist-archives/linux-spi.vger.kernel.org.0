Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC868CFC3
	for <lists+linux-spi@lfdr.de>; Tue,  7 Feb 2023 07:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBGGsK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Feb 2023 01:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBGGsJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Feb 2023 01:48:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECD298ED
        for <linux-spi@vger.kernel.org>; Mon,  6 Feb 2023 22:48:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso10613606wms.3
        for <linux-spi@vger.kernel.org>; Mon, 06 Feb 2023 22:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+/U+QeK9hEvR6ABz+IUCKA1l4N6KPAD5pigWZc0fCI=;
        b=PuElOJ85V+kFpfl3zu7zCKumBa64kSyH1+BScbb0uNTmSHsLoKEBVtlCQcoxSAASOr
         kzdOwtho7xSPQJ638hf/8BkmHQM3ghsoJOfZSnagx0kVzGk0PtjKB4++QsGlfES+s1oF
         L/xpGmzlhjFMLQZq5J46Fiirv2V63YA8P3gVSU56CeuIvaHQ3b4jPZ/IpwLXzaWuidNY
         YfcqmJPSo7AtuiMn5dGrneo1gPHQZ+OELT2dzmloA7f5x+pwvdWCxlFcj2/YV+7/h8+4
         of3pa1wV436yuX59pcLro+vfLxW3Cy4OxlhoCnzQFDeIeBrd+irSUt1XDUzqFPWPZNKV
         5kFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+/U+QeK9hEvR6ABz+IUCKA1l4N6KPAD5pigWZc0fCI=;
        b=FwIwM6QR60DuQWBB10qP6FdcI97vt9UkfatBpH5Yl8HNQGYv1Ty5KsQ77a4JndS3th
         x4y4QoNNKy3sTclUVcpnR/glz7JHLd6Wmh7LdJYC5tbud0enOJiWp/n3V3K+qYLHP5Xz
         vyPC4LWb9G/or5d9Vfp8UklQ5wdhZQrhvjjYMkiEweDQWJq4ndt9k1ucpnBHQCLCaWvu
         xR3KeDup8qyzA9wsFVS4zO3T43HT7nn50hSugwjDYs1sRBWMHWIjz427tYStmI7z9WlP
         /E1hiYJd3u4qkRLNYzJsTS+DgRjk1QpbEonZOWuo0OJydOxphKXzHFYKBK6fDN6kpFyS
         heAQ==
X-Gm-Message-State: AO0yUKXrPFYuzFhgukJVZqFaJNXjsvDZdbHQdl8W6l0PfJnJEBBrRGCL
        xU8Zpx+m+bAHZXShgGhWO7zaVg==
X-Google-Smtp-Source: AK7set8/0UZWOQVVrAPWQTpokDH093Y0jNluxoRsQ7HVW1Y5DviGGWIwbHisbRqsQTbbkAN+r4DDkQ==
X-Received: by 2002:a05:600c:44c9:b0:3df:f9e9:7600 with SMTP id f9-20020a05600c44c900b003dff9e97600mr2042146wmo.25.1675752486463;
        Mon, 06 Feb 2023 22:48:06 -0800 (PST)
Received: from [192.168.0.104] ([82.77.80.113])
        by smtp.gmail.com with ESMTPSA id s22-20020a1cf216000000b003dffe312925sm6097811wmc.15.2023.02.06.22.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 22:48:06 -0800 (PST)
Message-ID: <67e1d3af-d106-bd5c-f8d8-3f43a58975a0@linaro.org>
Date:   Tue, 7 Feb 2023 06:48:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] spi: spi-cadence-quadspi: Add Rx tuning support for
 DTR mode
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
        git@amd.com
References: <20230207060924.265789-1-sai.krishna.potthuri@amd.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230207060924.265789-1-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2/7/23 06:09, Sai Krishna Potthuri wrote:
> Enable PHY and DQS required for Xilinx Versal Octal SPI to operate in DTR
> protocol.
> Add and update device_id field in spi_mem structure with flash id
> information. Xilinx Versal Octal SPI driver requires the device id
> information to perform the Rx tuning operation. Since there is no common
> Tuning Data Pattern defined across all vendors, controllers like Xilinx
> Versal Octal SPI which requires Rx tuning to find out the optimal sampling
> point for data lines, this device id information will be used as a golden
> data.

Using only 6 bytes as golden pattern seems fragile, but you are aware of
that, as I see that you chose to read the ID 10 times to make the
decision whether the tap is valid or not. Other option (which is not
perfect) is to use SFDP data as golden pattern. If I remember
correctly, JESD216 suggests to use the Read SFDP cmd at 50 MHz, so it
won't help you much. In practice SPI NOR uses the Read SFDP command at
the flash's maximum speed and we haven't seen problems. But better would
be to use some flash OTP data maybe? I remember Pratyush has submitted a
phy calibration series in the past, I haven't had the chance to read his
proposal. Did you? How's your proposal different than his?

Cheers,
ta

> The reason behind choosing this approach instead of reading the ID again
> in the controller driver is to make it generic solution.
> - Other controller drivers which want to use similar tuning process, they
> will make use of this ID instead of reading the ID again in the driver.
> - Also, we can avoid hardcoding the command information and initiating the
> transfer in the controller driver as this should happen from spi-nor.
> 
> Sai Krishna Potthuri (3):
>    spi: cadence-quadspi: Add support for PHY module and DQS
>    mtd: spi-nor: Add and update device_id field in spi_mem structure
>    spi: cadence-quadspi: Add Rx tuning support for Xilinx Versal OSPI
> 
>   drivers/mtd/spi-nor/core.c        |   1 +
>   drivers/spi/spi-cadence-quadspi.c | 226 +++++++++++++++++++++++++++++-
>   include/linux/spi/spi-mem.h       |   4 +
>   3 files changed, 230 insertions(+), 1 deletion(-)
> 
