Return-Path: <linux-spi+bounces-4340-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E996154C
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 19:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698881F24389
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60C1CB126;
	Tue, 27 Aug 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mk4CKD9E"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14319EEB4
	for <linux-spi@vger.kernel.org>; Tue, 27 Aug 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779109; cv=none; b=i11TmLuOPG4/Q2A5XfoMoX5vo+2xbHRIbXbODhEwKh0wi/eDOZYzUXpf/UzD326cUCry3jFpUejk3D5xsFaW+RKQIfppK+NPNCP1T5B47M4d+z8d/Rv3viA8AU1aFSXeIVKBpNWm5FIMIA6ZHC8DysksPBF9hO2GSVIJw31Jo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779109; c=relaxed/simple;
	bh=sc/xj1pECF1comMS2pLezfWy17ZPZl9W9Dm5bqJCDQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B9xIbOirgf3m/qYEiK3DED0mqpT3naEQiRl9+vb7ZFaED5FnG+7L93lMRzRqRRehu+BNEDzC80WztUsKC10J8wtSTZ7WQeyvEA3XFFvxF87lcdUmpIgRDP4Nx6FcRPmYJKNGssDcssGRDos2I94fWsMwbIy0owddVKQAdQA0edY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mk4CKD9E; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-371b2e95c34so3384832f8f.3
        for <linux-spi@vger.kernel.org>; Tue, 27 Aug 2024 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724779106; x=1725383906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sc/xj1pECF1comMS2pLezfWy17ZPZl9W9Dm5bqJCDQo=;
        b=Mk4CKD9EDsYlYiUrCKDVdDIgYOqrBg8Xg+VrgbMJwsWWRcifcXGTIPioOLHe2QdFJa
         zBF1HtyLIBo4MiRqUftmqXkfIJbE+xgr7CVUHR/7QD6uwVH4h4uI48Ra815XrDrXXv/7
         e7JDtNtIzVBKKr/yKJGlXn8BZ3tZh7ouPbhN2BsePu47u5d4t5boPE8IhYxOmvQvMEZG
         FLBXpa6vjoCsTuVHPwS8896D+Z4/vsiCwAkNcH4KmmzOFxBwyc+g836U3POTeeS+OJhP
         5R120Pi1Rwmcdl9RM5YwagCFmd6dciMKEipMlGMOP6dW5eQa3zFNnsi0ePg2PCYaAA49
         397Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724779106; x=1725383906;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc/xj1pECF1comMS2pLezfWy17ZPZl9W9Dm5bqJCDQo=;
        b=JE4B8ntpWWqJIc7xsp0cudUWpqX6VkwZOh3fjGTkahJBoD8IYdScC0550egCSUijCK
         WHf5nCgFbWd7ybt/vtWK01w4nrE8n/qPrHvSEWvcAffLT2KxXSB1dqp91YP15m3KIl6D
         qd/N1a3st0kpKElFK31tMxLIe1pHKqMApiOup1SmRnKtRaUrfzNUiVXTDlOQT/AiuRvr
         Q6sB5YP4WHncwTwSDmq2l8ogWZWRo+7P72kt4fuSuDVPHBIN0Jy15MZL75bHW8nAAPdJ
         M4K+KugQy/lRgVAK/EaxvlJ7UxuVi6u0S8tHAKlrRvpceP4wTiPFozRH7KPkp0+rBGh9
         UsYg==
X-Forwarded-Encrypted: i=1; AJvYcCX3ANUeehT/GUqPSfqqqZ4isBYNJcJBDYfROyMMrVXnqY2BJqdqrY8rhFZmSFcBZaDyYmn2R8MGzfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3S8iiQr6uJWJOIpiZbNWhcqaI7TWnsx14d8BJbXB+IryhkK3
	9GetOiTXG7MVKGCGl/I6uwTh3mlK1SWuRsLhEgc5N8zgJKFu7goULg6rZwflOOQ=
X-Google-Smtp-Source: AGHT+IEdKN54VHi0TyxtS1/HMc8FF8vE19PVNsQxQEYiZ/zFtuG0jDrslQsmOzBObk9o55tKL3923Q==
X-Received: by 2002:a05:6000:459e:b0:371:a70d:107e with SMTP id ffacd0b85a97d-3748c7c1681mr2311250f8f.6.1724779105738;
        Tue, 27 Aug 2024 10:18:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8d1c9sm229231935e9.23.2024.08.27.10.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:18:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 254495F9E6;
	Tue, 27 Aug 2024 18:18:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org,  Haixu Cui <quic_haixcui@quicinc.com>,
  Mark Brown <broonie@kernel.org>,  Viresh Kumar <viresh.kumar@linaro.org>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  quic_ztu@quicinc.com,  Matti Moell <Matti.Moell@opensynergy.com>,
  Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [PATCH v3 2/3] virtio-spi: Add virtio-spi.h.
In-Reply-To: <20240326112812.31739-3-Harald.Mommer@opensynergy.com> (Harald
	Mommer's message of "Tue, 26 Mar 2024 12:28:11 +0100")
References: <20240326112812.31739-1-Harald.Mommer@opensynergy.com>
	<20240326112812.31739-3-Harald.Mommer@opensynergy.com>
Date: Tue, 27 Aug 2024 18:18:24 +0100
Message-ID: <87ttf551gf.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Harald Mommer <Harald.Mommer@opensynergy.com> writes:

> From: Harald Mommer <harald.mommer@opensynergy.com>
>
> Add virtio-spi.h header for virtio SPI.
>
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

