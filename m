Return-Path: <linux-spi+bounces-486-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC2D82F527
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 20:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B01A28438D
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 19:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FFD1CF9A;
	Tue, 16 Jan 2024 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq3WJ156"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B251CFA9;
	Tue, 16 Jan 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432480; cv=none; b=j4lWUd8LxSexITrlDa+subZDgJ1izpFWkiYsXMa3LbeZdTRVEDDWJ/+lwMlm+kXPDauCbKeD3RpyJRbiWDa0HvdSmR4WSHNqtDjEIwN5XLYOI/qiYQHL+La2puB4nHms8oZPFSPWHj+iKBXFlgOvckSgMMinhzn3JNnnCFPAdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432480; c=relaxed/simple;
	bh=FLyY7fGPGkmANkBd+1fYWz9D8obvYzG8x4WtkdAU9D0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=trhs0wK0fGgMvSYp6UUCTNqVAZpKVhZEXzZBjJvpx5/Z1a+2A8VduxjoHwbNEajGVAv8VcrWSgt2T1a+webx3VjqPHOC8O3bFmJ6t+ElZkG96y+URxveGhQEXuF6aOgdq8+pdzVmXPy/ve7xyrMQu9Ljs/jmAawO0KgUu6yvP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iq3WJ156; arc=none smtp.client-ip=209.85.215.182
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso8037090a12.3;
        Tue, 16 Jan 2024 11:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705432479; x=1706037279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=utY947vVqyDGifATftw5KQ3wsfiYaqOmw9aPkLWLkI0=;
        b=Iq3WJ156/+Cjzh3xyOohagvgCx/MDXAnu4zKabzL69E2hLEr9evN1O/w45vDtk6o3V
         q30/ZSc2obWobbuNmXMleO0sh7zo5ZwUO8zeAGpJ2lOKm6nG0Df3Ao/5gyxJmAfXfign
         TYS4cfmgQ3l7+13rajHaI63BTqADFdwAc4PK8nOEbE/naO+qIp0fsiuFc9NCzloEUd0D
         xpvahcZ6yWS9cAxolpKsucJnzYC0R66cUIKyLzosSiTBvQ+imWjyNTzvA7kM0cQ2L6me
         q5l50JT4jXddA3us1vjWcHhFBMgvt9Oy2/mEyLgd4p0dktuz0j3Yt/k//bliFbcCqCaN
         KozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705432479; x=1706037279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utY947vVqyDGifATftw5KQ3wsfiYaqOmw9aPkLWLkI0=;
        b=nl2TYZ23F4wpuxYQKlXArX7FvzEQcRI4CSU5l7LXah8/HatYwuyPIsIWmo9po9F8xV
         qNe3oyXVGTl1QKvKXkJ/rVVGrehskxAeuvKaonNAd5/S20IjSmCTCcbgWhLbQ/UiUsez
         GFWgpaWxINNZ9brWCfCnXju/PT3kwRW82F1s357z2zsVjgVU6uvjxZGrGihjAiAMG3wQ
         m1WkJRVN6Jc3ZiVezJ+qSv1YGL1zKnguycm097Mzyagj/BkKFrmN7CllypbRKRPU+KCJ
         rNrkISwGD6XmHNb5dhPmJQ59i/J7tl6AIpwyGa97avAHRM4uA+1X+rvNEyBoyKwixdXJ
         UBjQ==
X-Gm-Message-State: AOJu0Yy2NTi6knVIcb8ITCVwnJjWh/MLwlxn8yFfshFYKCLhBIe2evYm
	NKnZNIvJKNXWynztMaov1yk=
X-Google-Smtp-Source: AGHT+IF2pXKzCN66lDy/64G3pYoBs6RfacN8vPqUHjLJ4PvgT7cRvGPvDlVSi+rcxr0YF6tS4XA8Vw==
X-Received: by 2002:a17:90a:a881:b0:28f:f2b3:67a9 with SMTP id h1-20020a17090aa88100b0028ff2b367a9mr53614pjq.77.1705432478920;
        Tue, 16 Jan 2024 11:14:38 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5c15:9a6:f612:d37a])
        by smtp.gmail.com with ESMTPSA id sh2-20020a17090b524200b0028dfdfc9a8esm10687011pjb.37.2024.01.16.11.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:14:38 -0800 (PST)
Date: Tue, 16 Jan 2024 11:14:35 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-spi@vger.kernel.org, kernel@pengutronix.de,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rayyan Ansari <rayyan@ansari.sh>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 05/33] Input: synaptics-rmi4 - follow renaming of SPI
 "master" to "controller"
Message-ID: <ZabVmwGnfHSIwIub@google.com>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <5257de51fe406cf8405310dd638f648a232f4a6c.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5257de51fe406cf8405310dd638f648a232f4a6c.1705348269.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 15, 2024 at 09:12:51PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry

