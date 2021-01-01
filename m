Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3A2E838D
	for <lists+linux-spi@lfdr.de>; Fri,  1 Jan 2021 12:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbhAAL2c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Jan 2021 06:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbhAAL23 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Jan 2021 06:28:29 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10138C061757
        for <linux-spi@vger.kernel.org>; Fri,  1 Jan 2021 03:27:49 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kvIax-00B5KF-D4
        for linux-spi@vger.kernel.org; Fri, 01 Jan 2021 12:27:47 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8]
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kvIas-00B5Js-4P; Fri, 01 Jan 2021 12:27:42 +0100
Subject: Re: [PATCH RESEND v2 2/2] Add support for Realtek RTL838x/RTL839x SoC
 SPI controllers
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201229231904.2558916-1-bert@biot.com>
 <20201229231904.2558916-2-bert@biot.com> <20201231142319.GA28104@wunner.de>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <e9870e2f-d16c-3ed7-d672-7baa9a5e278c@biot.com>
Date:   Fri, 1 Jan 2021 12:27:41 +0100
MIME-Version: 1.0
In-Reply-To: <20201231142319.GA28104@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/31/20 3:23 PM, Lukas Wunner wrote:
> On Wed, Dec 30, 2020 at 12:19:04AM +0100, Bert Vermeulen wrote:
>> +static inline void wait_ready(struct rtspi *rtspi)
>> +{
>> +	while (!(readl(REG(RTL8380_SPI_SFCSR)) & RTL8380_SPI_SFCSR_RDY))
>> +		;
>> +}
> 
> I'd suggest calling cpu_relax() in the loop's body.
> 
> 
>> +	err = devm_spi_register_controller(&pdev->dev, ctrl);
> 
> Since you're invoking devm_spi_register_controller() on probe,
> the controller must not be unregistered explicitly on remove.
> So the ->remove hook can be dropped altogether:
> 
>> +static int realtek_spi_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_controller *ctrl = platform_get_drvdata(pdev);
>> +
>> +	spi_unregister_controller(ctrl);
>> +
>> +	return 0;
>> +}
> [...]
>> +	.remove = realtek_spi_remove,
> 
> The ->probe hook otherwise LGTM.

Thanks Lukas, will fix those issues.


-- 
Bert Vermeulen
bert@biot.com
