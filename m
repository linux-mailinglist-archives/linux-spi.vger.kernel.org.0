Return-Path: <linux-spi+bounces-476-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4796B82E935
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 06:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA581C22860
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 05:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394748494;
	Tue, 16 Jan 2024 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGDdkVID"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E8848D
	for <linux-spi@vger.kernel.org>; Tue, 16 Jan 2024 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-204fdd685fdso8197770fac.2
        for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 21:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705383532; x=1705988332; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7yUFUU66f8Pu7tZiWG2Vaq0nR6vJICcLg6Vq70eDraI=;
        b=XGDdkVID4TliI9wt9dMQwYQ0MPSduBTLaj1L91PmAhnzdagIbRNczkoJPuL34JvuF3
         cLCQ0GVeZ7hzr0BaZNf3+V9WIfjXgH8LTH0D8Xt5IvtIWFtu7AQ5xnDqPAgSQmcPjv0T
         lQ0FEvdJl9jPjheo8YQeYji2O/mp1NCvraxvfriDwq1hhpnMB+dxmT2l2tw++aRfdEdw
         5hNndArU4FceBnHQRaa/OB7Qml51v3kiOr7ybPTP6qTYn/ObWFwlHxjiJ9Cs99spe8a3
         QR79LOb/YR03iowbSAhXBrOxFvTRvzJClZD5pZzbzLGsukxUvZc/ot38UjnTsJNbCkWA
         laWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705383532; x=1705988332;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yUFUU66f8Pu7tZiWG2Vaq0nR6vJICcLg6Vq70eDraI=;
        b=EnxoEwrlsmB1xTriFHicAmQOPwVz3bZviBHXRdKXezb1uaepgWdl9VAO1iqCLLgUws
         dOFv106f2KFZIOvKTQQ6iSIDT+N4KbYaWypEO/8xDujTNtAVDykA0sWnU0GPvoPWEKp1
         kCTHZoIFlfSAfth090Kj67h59Zs1jd65jELBJ8mp61LaXnR3pUBqet3zN1uvnO+JvUpE
         DLz71XUJ2YAgIH4HWeg1IIsQu26hdapKUP5YBaBIi1Btvpfj7JRh9Yt/ktpQGPqx0cwT
         m5zm4G1Zp3BDcckOPDKI18mmWO4vAFpU9I6HTxP74I0lirv5hIdc9meInPPHTD/CBMYS
         GzGA==
X-Gm-Message-State: AOJu0YzkevEpQRl8xC0/l7iWWgFhd0l52WdHT04FiEglZTO+IP1h7H56
	TTvoEc3tgGG4LVFq30DCN4peCw3+O84ahg==
X-Google-Smtp-Source: AGHT+IEfDKhikqk0PQDjlpmEeKuxVyvTuSVywSGF6JHipf9nnyT0gOg1FuJ6LMT4BnZJjbrWRG40Jg==
X-Received: by 2002:a05:6870:414b:b0:205:ccc5:2740 with SMTP id r11-20020a056870414b00b00205ccc52740mr10523146oad.10.1705383532496;
        Mon, 15 Jan 2024 21:38:52 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id n9-20020a6563c9000000b005c21c23180bsm7951734pgv.76.2024.01.15.21.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 21:38:51 -0800 (PST)
Date: Tue, 16 Jan 2024 11:08:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-spi@vger.kernel.org, kernel@pengutronix.de,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 26/33] staging: greybus: spi: Follow renaming of SPI
 "master" to "controller"
Message-ID: <20240116053849.ymahw5hzwmtsqglh@vireshk-i7>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <188f907d08d4a57d1058f01bc4939f209a4c8e43.1705348270.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <188f907d08d4a57d1058f01bc4939f209a4c8e43.1705348270.git.u.kleine-koenig@pengutronix.de>

On 15-01-24, 21:13, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/staging/greybus/spilib.c | 66 ++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 33 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

