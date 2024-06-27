Return-Path: <linux-spi+bounces-3621-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD2919ECC
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 07:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F297F1F21EEA
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 05:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E71CAB8;
	Thu, 27 Jun 2024 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIuuwKLH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26561CA80;
	Thu, 27 Jun 2024 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719466775; cv=none; b=qH3hgco7GpCAOre02bg9ojPemLTI/N3n7fcnWNbvkOGIzMbWXwCC0l6/KnVjtvG9WW3u+bBih3ZDJBSeGs+bmtZzF3T+NgZGqgia3FXIxRaTwCsJD/fGZ12R0FzXVKCBKZ2B2pUPFn/XamwRVQHTQ44FnW6r/7efWpv1GiuKNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719466775; c=relaxed/simple;
	bh=GN2hR2aPS13XhOLzmH2mWt5vxx0fLiN9+Qr69fXDhyc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UMffnbP0pwloAU2YE+P/4tLjEgi3fk45vE/iRukmiSyQiPtdufVtEeruoKNztGsv5A7OtUd61rR8VBaPSHMoCvLn6jvSjZNhjJaf2DVCzS1nQ//efjudDDnlmbZv0QTHdxOR4pPqkSxVzIhWZmu4mggdH2OLBz5eYphOCchJAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIuuwKLH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4249196a361so32086885e9.0;
        Wed, 26 Jun 2024 22:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719466772; x=1720071572; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GN2hR2aPS13XhOLzmH2mWt5vxx0fLiN9+Qr69fXDhyc=;
        b=SIuuwKLHFkdAyH7yUnQIEYd7X2l03uaI5hAjP2S/PPKoX+Ec/eJAa1iJT/7AkPFAsN
         B9KowNpvSGde7L3fi+ZApXSa6YPqRAGFaZQWTzwm6YYMqczWqoWvi6J6x0W4I9UCqlQH
         en5FQ+ahi54mmKKR2qTjB2VLsBkRC/qU3uMXmMTQmVYIvzvaFVyFM7Lzw2qRAhjDcOKL
         Q0rCBGGjyOQfcol3N3t2vhgLvyuCtuyO8CF+NjybJvs0mUbVZCWpofrE+Y4N/h4iNHEV
         LYhADeoLlanqb9GnZ+B6Ebt4wOlvQ+l/VmaLwwK6hyoKtcnMgpWmHJoHk8fM2z4oKHQP
         icgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719466772; x=1720071572;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GN2hR2aPS13XhOLzmH2mWt5vxx0fLiN9+Qr69fXDhyc=;
        b=N6J+zNA3CRor1QKzuylrBf8yUyJidytLjcrqBSQbqdEdJlFVwut4FOxGT4eTdpcSq9
         eR+Awd3itVkcHY0LmiB9FIpCL1qSys1A5luBTT2ugzegDAXWdij+9Pdi2Vbwfpl0SbqG
         OPf2o07d/NyGXSxVzn+lIsSoEhOeqxlILmxGjhyWC/99m6rwlpsZZjs4WusmztDVqyfd
         nUCNXEocGQ+r58lIwi7kVwx/J0OtTKhfIBc4SQ/oAAebBYe4L9hYGljJIy42NxMnKZJs
         QWAVz/Bc/gV+wwm16PszonoZO5lguUDqFFZ/b2eA33U5Qgo+7HVdp4EJrOcLj+TEZ3U6
         CYsA==
X-Forwarded-Encrypted: i=1; AJvYcCVi77jmEo0dpAH4z0rB4h3i2dYimNu8K3hNZRY9YEMT6zTl00SUu6ccOjb3kfjXL6rrzx3Bq44RIfYFo2f3p5S14+HWn3mSX48Ziyj0o2BqYTYwHNSN0Nc3HBcxzugUAPu1ceNU8T7B
X-Gm-Message-State: AOJu0YycfSCgdr381Ng7ZsD0BPaHVgvW5JYUc1qubnl3XJvbR2oI5n7v
	0b248s77PCkMh86k9as499cGsA4A7zPicI2wTduwS2R4FPW7hunAsLIBe5A0IVQ=
X-Google-Smtp-Source: AGHT+IFRD3sIGxB+NdLXR6gS3y6INWWAKQdlnKzOrS+6JdgKu9C1bhhZOkkF4Vs1Wo6xlUd44JB5mQ==
X-Received: by 2002:a05:600c:5686:b0:421:7aa1:435 with SMTP id 5b1f17b1804b1-4248cc58a4bmr77810095e9.25.1719466771556;
        Wed, 26 Jun 2024 22:39:31 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b65731sm9336395e9.14.2024.06.26.22.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 22:39:31 -0700 (PDT)
Message-ID: <8f7b91d323d042699ec4eecc577f7d502d80e7c0.camel@gmail.com>
Subject: Re: [PATCH] spi: axi-spi-engine: remove platform_set_drvdata()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 27 Jun 2024 07:39:30 +0200
In-Reply-To: <20240626-spi-axi-spi-engine-remove-drvdata-v1-1-1752e372dd5d@baylibre.com>
References: 
	<20240626-spi-axi-spi-engine-remove-drvdata-v1-1-1752e372dd5d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 14:45 -0500, David Lechner wrote:
> platform_get_drvdata() is never called in the AXI SPI Engine driver, so
> platform_set_drvdata() is not needed. Remove it. This also lets us
> avoid the final error check in the probe function.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



