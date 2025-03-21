Return-Path: <linux-spi+bounces-7281-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582EA6BFE1
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 17:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0F016BB28
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4ED1D86F2;
	Fri, 21 Mar 2025 16:28:41 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E31228C9D;
	Fri, 21 Mar 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574521; cv=none; b=glqkqlMtYCpsuzSGLqrWSoOMjE7kgljs2vwtvs2S7Z3mbYibMUsZrrWkE9J/v6hcpzBAdRIWrDpnxxMQ5SuTD/O/haVXTR1gvJ+vz4nhLk+Xp0u4dOzd/kvWZWO7Y5rAUGsRZUvrWieLa1QFLyWuU6GvE4L9fzfWXB06IHltURI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574521; c=relaxed/simple;
	bh=R+Ec4aiXeWd9fjSjxhbIB3UkueMseKkz0W5jsG/A6Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAIAiWga9J3leLLGXabVr5mWpjqpTqBWiQuU+jvbv0kwdwuN6r4Ha4wzTEtl+h4MoYLN0XV8Tly3LqTq21nKYbu2HrTtZ0i0bUiJet9mdVxdvxBDVkTWI0mAzrW/El5R5a4LQ9qdxnFMFEQuxoeE6JfAiEeHbsRcE+Tmbf7p9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so3890455a12.1;
        Fri, 21 Mar 2025 09:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574518; x=1743179318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+Ec4aiXeWd9fjSjxhbIB3UkueMseKkz0W5jsG/A6Zs=;
        b=YRiohsX+rRFXB5EsvB+K4c3Tj9CWqceoMag2aKyhi6ht/kmlgCXuhszDAHNtCRK/HJ
         wbRxMQUGJnODbXe19tnClHQwn/MPDLYEYVCtps0esWLFVXoCkpl88ExyWYI6YNOXX9qM
         40lMrpo+lTISvQqdv4s7a4pMsmqIQmSGIAOKM7rE3x5g6XmL+tHnnAyzJSL939Gz9uLg
         0vioVUlveJTKrw4o8tf+P7EEv7yANGkA/5kHyWKXhg41qkD8nU06v1b+Gq9cmInSwGtG
         uqaMi4LFp3YZ6QrQzOeirOW3Vr7YjIZyAFO5LYMVlzWS9ZWeAL0yq/MXBV2/L+C8yJel
         qojw==
X-Forwarded-Encrypted: i=1; AJvYcCUiX015ebfid9jTdtMLXAuzSzosY5Sa46pK9FFCybTc4kQLXBSqMkYWDOL5SaTx9n4JvCGcnOyhP4Pl@vger.kernel.org, AJvYcCWbJr0diKg6tflGAuRzRjbWV5t0efuJM5QDuBYQMYHPlJ7rvKlebPGOTu/QMsgdytoYE5fXqZqXLHFSdtY=@vger.kernel.org, AJvYcCXfFWve6UZcaGY97KSiwPc3WzSXGJiLQX5ejhsGShjAb4rUHupvwbovncFqPAoV/VOMc5EiXICaEVog1M4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/ygIMNuDBJ5JiLOaSQ/s8MkI2ezC4E+BZWZX2bnHwEQUcVV7
	S45aoQ/7y8en/v/34ZSyL7e7xypvjulJI0w6e0p/T9obc09p12rA
X-Gm-Gg: ASbGncu+KdsOwa/Wv8vdiWiaR3x9PNl6Dqfh/fefbuTUUjdUGdgwLTpEhmHZyaQHFvp
	EyRn0wgVJzHbvHxRYU/ZEOaXnsE2S6fM03HfmgK31FkdUoK1bkw7TgXIoOXSs9f93/Ihx3lO5XI
	hvXC+OyqRmMMoLsozTRwJQq9DKlnQx1snxcUR1+0iTbFoPk9l+Wcxa3UV0W1jZNgyeV+dHsyvUF
	KwwgCgoaTHTDMkT2efgCi4uJEh5IMGqHmyH/c/mk5hGJhNGHXUnoKQnf8aWHSbDhcA6GBTX4dcw
	ONnqYK02231rcM45EIDWGka5MAJIwT1vgbyP
X-Google-Smtp-Source: AGHT+IF3Y1nlm1q24hCDlL2xCcrRUAMYeM66rfzyDf3IuHTh6oHYbpiVZDk9ODGrkAnZjmTpth9WFw==
X-Received: by 2002:a05:6402:3483:b0:5e6:1352:c53d with SMTP id 4fb4d7f45d1cf-5ebcd519820mr4353887a12.28.1742574517537;
        Fri, 21 Mar 2025 09:28:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf687fbsm1589504a12.4.2025.03.21.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:28:36 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:28:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, jonathanh@nvidia.com,
	skomatineni@nvidia.com, Mark Brown <broonie@debian.org>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, noodles@earth.li,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <20250321-colossal-binturong-of-debate-055aeb@leitao>
References: <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <20250318-psychedelic-thundering-guppy-22bba2@leitao>
 <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
 <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
 <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
 <20250319-aloof-rottweiler-of-perception-4c1ad4@leitao>
 <5doq6itaz6uicvqcn37q2dkaxyzy3etz5qgv6wlsyd5troqlag@yqs6ltjp3gsz>
 <20250319-unbiased-rousing-finch-95ecdf@leitao>
 <ac44uxpojpov7fcdx3qfiif3idhbp2hrrr4efqeat6jazbosv4@uoy72g6u3ibf>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac44uxpojpov7fcdx3qfiif3idhbp2hrrr4efqeat6jazbosv4@uoy72g6u3ibf>

Hello Thierry,

On Fri, Mar 21, 2025 at 01:40:44PM +0100, Thierry Reding wrote:
> Can you maybe help clarify at what point you start seeing errors induced
> by the recovery mechanism?

This is after a while. Something happen to QSPI and the warnings and
device reset failed start going haywire.

Most of the machines are fine, but, some get into this situation.

Thanks
--breno

