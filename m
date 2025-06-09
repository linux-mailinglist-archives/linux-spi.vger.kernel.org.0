Return-Path: <linux-spi+bounces-8417-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48270AD2881
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 23:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1693C18858A0
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 21:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DA51E1C1A;
	Mon,  9 Jun 2025 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OUWpIJ+g"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDD18BBB9;
	Mon,  9 Jun 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749503546; cv=none; b=q0uZEvgPSWgrL+ChPh8oscbAQV0DhDtolABXllWTPEO0WSQqeKhFT9e+ecs0Z4LErXojyOJk3AYqh/4FFPXLqv1E5Fa8x7XSgaM4Fja+gznvoPcDx8xd3RkOH3+PklcLEKaZWceCjB2gzoRiX0Kf8c6ObH0EMAYe6Yf1yVZWVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749503546; c=relaxed/simple;
	bh=v7Wyj6Fr90JtaXx9mPLXXO6DL0XRpjX4OlNToy9WZjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L48rMCbvSb5DryH8ApF33soNEEC/MSFRBqZ6OJe032qv0l2Tk0Nfd0u7+9Mb/MCuUNbkPEFgJ4rT/UUhnUn8+AyL5B5mddd/QT+qyGZVgjr74gEoK7Z1vQOXHmekKlfMViSQC7/BHBJeRd2K33FRQ8LLuMXYiOvH4isxMygytWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OUWpIJ+g; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 559LBqg12102748;
	Mon, 9 Jun 2025 16:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749503512;
	bh=46ToyLg6oP+8zwm16diPabgfMuXMygGMCndJmaqJXRs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OUWpIJ+gkR23sr1WZH3XJOiD/1ICYbhXvrJRY/rFW2cnGm9SKgz7Gegvu2AZ05vmw
	 6F4qfYUZFF7VVEM75LWcXJ2qe1UQZdjnRVJCjrzsmH7cMxh5r2iJx+c0sVsTVqFFgo
	 mz8dkAxYbReDt9bCcA+4cIwIoXoNny+m56ljEwj0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 559LBptj3958032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 9 Jun 2025 16:11:51 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 16:11:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 16:11:51 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 559LBoxI1847054;
	Mon, 9 Jun 2025 16:11:50 -0500
Message-ID: <1983260a-4362-44ca-af1a-0e20d2fee6db@ti.com>
Date: Mon, 9 Jun 2025 16:11:49 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] leds: lp8860: Check return value of
 devm_mutex_init()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
        Vicentiu Galanopulo
	<vicentiu.galanopulo@remote-tech.co.uk>,
        Will Deacon <will@kernel.org>, Han
 Xu <han.xu@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur
	<yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones
	<lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>,
        <linux-spi@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-leds@vger.kernel.org>
References: <20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net>
 <20250609-must_check-devm_mutex_init-v6-2-9540d5df9704@weissschuh.net>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250609-must_check-devm_mutex_init-v6-2-9540d5df9704@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 6/9/25 3:38 PM, Thomas Weißschuh wrote:
> Even if it's not critical, the avoidance of checking the error code
> from devm_mutex_init() call today diminishes the point of using devm
> variant of it. Tomorrow it may even leak something.
> 
> Add the missed check.
> 
> Fixes: 87a59548af95 ("leds: lp8860: Use new mutex guards to cleanup function exits")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   drivers/leds/leds-lp8860.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
> index 52b97c9f2a03567aa12d4f63a951593a5e7017d5..0962c00c215a11f555a7878a3b65824b5219a1fa 100644
> --- a/drivers/leds/leds-lp8860.c
> +++ b/drivers/leds/leds-lp8860.c
> @@ -307,7 +307,9 @@ static int lp8860_probe(struct i2c_client *client)
>   	led->client = client;
>   	led->led_dev.brightness_set_blocking = lp8860_brightness_set;
>   
> -	devm_mutex_init(&client->dev, &led->lock);
> +	ret = devm_mutex_init(&client->dev, &led->lock);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to initialize lock\n");

I don't think the lock initialization can actually fail, if anything ever breaks
it will be the devm allocation, which is a ENOMEM situation, so probably not worth
printing anything. Either way is fine for __must_check sake so,

Acked-by: Andrew Davis <afd@ti.com>

>   
>   	led->regmap = devm_regmap_init_i2c(client, &lp8860_regmap_config);
>   	if (IS_ERR(led->regmap)) {
> 

