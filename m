Return-Path: <linux-spi+bounces-7561-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0716CA8723E
	for <lists+linux-spi@lfdr.de>; Sun, 13 Apr 2025 16:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCDF189380B
	for <lists+linux-spi@lfdr.de>; Sun, 13 Apr 2025 14:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746A01A8401;
	Sun, 13 Apr 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN+WVC48"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D65847B;
	Sun, 13 Apr 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744556066; cv=none; b=rOMe7tXtujAsCSexF5WsfQj4/FUQ6WxxsSh7S+AfNKbkNeIUc+KsafmV38dIZmoQAt8WSJjJQ/XQJSp8fZQ6NC8YjHL0DBADFEGftT8nPr8Y7oWZevOuCtDpk7eFWFOYcMs2X0WOXFjHXMh6gV32QJ0aoRJk6NJBVz61NhyaD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744556066; c=relaxed/simple;
	bh=dvelPXkUdIwCAdAldSQ4W7PyCYIe7eFMCwQTwWTrGcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0q87zgm97D48RZ0/jLx9DUoSlnqgr+cP4sIx0D661ZCuOMPA9zouCQDmmu/PIkOPnR0RsBkyn5QRww50wdeK33xDnjaYMgD6xzkRUrKsepfAsFuSedRPA9b5WUNs1GFpiVI/s4WoacZ8a/V6BFJfHEzafEUrLvyYLMCl17Twfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN+WVC48; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so5699804a12.1;
        Sun, 13 Apr 2025 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744556063; x=1745160863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvelPXkUdIwCAdAldSQ4W7PyCYIe7eFMCwQTwWTrGcA=;
        b=kN+WVC48S4I4jG3t8eO90+QdtaQ4fN0jkGRaytHPmb/5CEb2UF0UzIOtGm3CiynZhg
         ImfOpePGsaHN6tbAQrrC0JrvJgYMrdKkv7JBQnOmWoPGNu/t23BGJ3JVQIlzssScdt//
         vzSnfGMe5DYT3zeZ1WDJO5uDn2e0Q/P4Y3aOI0oZRKJha3X6rfANGHs6yon8rK1uitxT
         SkaUGwNQrecEsUkk1v34PRFJxKsNbfIaOJwPdWwh+kMmazZ0O7AziEvMpJbSJFKymGPf
         YhdE00FfjxEgeAzL4s0VHn9yqXJWVS07WxO9GfwAQfII9tTkF/sEUvq8Gs8CBOgMTq/l
         KGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744556063; x=1745160863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvelPXkUdIwCAdAldSQ4W7PyCYIe7eFMCwQTwWTrGcA=;
        b=cgOVSI+wcGGfWkgNMqCuvQbc4cqtJ4s1YoMZUifcPTY+H62/jIFWTeXlUmcybPQ6YK
         yoWNnGWtNJDi2Y1KjfTcD988TegSlemvCJqigdqIs0zrUeBujlwo8k8dTBmFzfMZUv52
         7wJocw2zRsW+7u0FP5VTug6kZKkXijIs0lktMRmqdkO5N91o/Cf0TeZH08sgr31pbvw0
         mYRrYq+WDZzVcP+c7ar+xZdRVea69xJMXdJyZDUYgMfNDiM40vn+N1Q4jc2lM7rRLtA/
         0TiUo8ett7oF2tCoZrsinDP/018llnhJfUYmT/gYGoM0UxPPKi9ipJaFt6ZpJCEs2qmx
         7rog==
X-Forwarded-Encrypted: i=1; AJvYcCV587bk+b0+XlRHlV0w7pP2cVAbSoaQwGPTp2hvlKvm+UXdPuvNoXh1/vuCJq4A094dxlTbNcKk6MMN@vger.kernel.org, AJvYcCXY5MwcAEqA4EiJGpCTPvzteb4K7kMJ4WUrjiYiKptQXga0sMvAdN+GcFx9LSllF8pN/MQn0qQbW57KIkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMrlv2Sq7gCAGdROYIuS99+lUqr9L48kQYFnBHui87kzqTQU4
	CGjEyhFR7mTJlqDQ8wprmf+Zlw+P6p3ziC8EcefNlLJC7yYDW7UA
X-Gm-Gg: ASbGnct2kkOmkYXwWYMP74x3w0de1MChdDpdpLLd3C+b+snB9sKSavmGxW1l+qhUng2
	pjPIXMuAbzUMgzJV/uyDdBn5c047644hiK5icTTOLDDlcq633MS+WgXn41nIHclQSFXc9bJpg8W
	alJJPjOq9JJn7elg4F9YLbm+vC/r1Oav8pGjsc87XmNo6o/uErbI3C0ehVJ/d8L0T7jPjJMI2pm
	4x3rsQB5e9uViOYFtxJXMFtv8Jgko7zrv1EW48qOK34ayn8yfR1jXGsJUBnJx3sE2ImOXHiEx56
	qCS/7CKiFThiPlZlw42NnORZwrtTdvRXgIEBkTOe0w7md5/iRuBKSq2lijU=
X-Google-Smtp-Source: AGHT+IFgqGhavNUgVnAURGWH2ePtNWVyQ3zUa0nRZiYGvzy8qKrKzUY1RZR3SZ91BcXNuvYs1xz9TQ==
X-Received: by 2002:a17:907:1c07:b0:ac3:3f11:b49d with SMTP id a640c23a62f3a-acad31f535amr897088366b.0.1744556062628;
        Sun, 13 Apr 2025 07:54:22 -0700 (PDT)
Received: from jernej-laptop.localnet ([80.90.89.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1999d96sm741027466b.0.2025.04.13.07.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 07:54:22 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Mans Rullgard <mans@mansr.com>
Cc: Pan Nan <pannan@allwinnertech.com>, Maxime Ripard <mripard@kernel.org>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: sun4i: add support for GPIO chip select lines
Date: Sun, 13 Apr 2025 16:54:18 +0200
Message-ID: <12643311.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20250410115303.5150-1-mans@mansr.com>
References: <20250410115303.5150-1-mans@mansr.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 10. april 2025 ob 13:53:03 Srednjeevropski poletni =C4=8D=
as je Mans Rullgard napisal(a):
> Set use_gpio_descriptors to true so that GPIOs can be used for chip
> select in accordance with the DT binding.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



