Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D952EA7D4
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 10:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbhAEJpL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 04:45:11 -0500
Received: from smtp2.axis.com ([195.60.68.18]:26248 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbhAEJpL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Jan 2021 04:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1609839910;
  x=1641375910;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CeICFgPaITmi9nZ9tSZ1FQ/bbzfnJaESHlPO8SjV7sU=;
  b=IjI+E8+Tgo9md3pRitg0ZJs4R1fWGYblmW4VsHgQEn+eRJdFCIfX3uxq
   4f84YWjfrEyNyRyt12TkJq/UU95aXowtzpQ3EG+LyYwi6Uy2i4LTYx6DK
   kyIKz3LopqrrAa3Imo3dWTqM+ueKpcMsRqEX/hQlOpHz62Wyb0sEDKLLl
   WC0v3M986i/0GKufzsl5e85T2Mjo4i+RyfO4e2JT0P1yxVmq2FwJFVG1V
   x1LNBq6WZ2UkyExmPJpuzi6FjFy1tYXW4pHFW/4yJXPJqazhjGTWMlFYc
   NtlhPyKGydTFS7NVUfAZkJYj21jDDn4OD25qQF4fRhlRILlgJ25qyYT7d
   A==;
Subject: Re: [PATCH] spi: spidev: Fix so the module is autoloaded when built
 as external
To:     Mark Brown <broonie@kernel.org>,
        Gustav Wiklander <gustav.wiklander@axis.com>
CC:     <kernel@axis.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210104153436.20083-1-gustav.wiklander@axis.com>
 <20210104213437.GM5645@sirena.org.uk>
From:   Gustav Wiklander <gustavwi@axis.com>
Message-ID: <124e3214-37b9-524b-7888-a31e8cb455da@axis.com>
Date:   Tue, 5 Jan 2021 10:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210104213437.GM5645@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX01.axis.com (10.0.5.15)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 1/4/21 10:34 PM, Mark Brown wrote:
> On Mon, Jan 04, 2021 at 04:34:35PM +0100, Gustav Wiklander wrote:
>> From: Gustav Wiklander <gustavwi@axis.com>
>>
>> The spi framework sets the modalias for the spi device to belong in
>> either the acpi device table or the SPI device table. It can never
>> be in the OF table. Therefore the spidev driver should populate the
>> spi device table rather than the OF table.
>>
>> NOTE: platform drivers and i2c drivers support aliases in the
>>        OF device table.
> 
> Why is this a good solution rather than ensuring the the OF IDs can be
> used directly?
> 

Hi Mark,

You suggestion is of course a solid alternative forward. However, the 
downside with supporting the OF device table for automatic module 
loading is that a lot of spi device drivers must be updated. Also
it is unclear what is the preferred way to do this in the kernel see
this patch:
https://lore.kernel.org/lkml/20190618052644.32446-1-bjorn.andersson@linaro.org/

If adding support of OF device table the spi device drivers must now 
include a MODULE_DEVICE_TABLE(of,...) as the spi device alias will no 
longer match the alias in the module.

This command gives 186 spi device drivers.
git grep "MODULE_DEVICE_TABLE(spi" | wc -l 

186

Best regards
Gustav Wiklander
