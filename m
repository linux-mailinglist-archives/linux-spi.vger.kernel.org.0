Return-Path: <linux-spi+bounces-9962-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0187B512C2
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 11:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47F54E2E9E
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 09:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364BE313E2E;
	Wed, 10 Sep 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBS0yNdg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247163148B7
	for <linux-spi@vger.kernel.org>; Wed, 10 Sep 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497184; cv=none; b=et7WiuKiKNGAtC+7M9WaaFJEM62cmSLaHtUEq3m07beBdooH8FtlUu+Umswk4yi4GFaxOgeCbOnasXAUweyByt3jYhEmVEtOg0BNLaDBWLoJNeR6TJ/197P46LFJcEL6T7S35f1P53Qk+qRriXmUhhuaVf9wrpip4Ts7YZrDjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497184; c=relaxed/simple;
	bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dpDERYJnAcaaxAC+vX9n0EbJ4WKjyxKttQJdjlNBCPCI0zV9Ysk5onZThxE6wWClCU+fzE4T0UWdVdGlYAbVcggE9cHX/0lFgyCVnuU3CNRWj40Fpds/P9cvBU27rbwgtSVEEUtbP3S1U11QO2EKqG00ER1TI2dV2VF68KE63Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eBS0yNdg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b042cc3954fso1095886666b.0
        for <linux-spi@vger.kernel.org>; Wed, 10 Sep 2025 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497180; x=1758101980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
        b=eBS0yNdg85VxplV5PCne2faobtNgQxz+twlD68Pv/00siAxIwglmWONslGqd4gBAU/
         4niFf9F3VP+vKf0OC89wthO4adjThbN5N+9cMOqLxFIG6/sSJmmczZ4NUy98aYsb3204
         5e331kyX08f3b+L/zRJD5C7pSjb3GCf7dGtwHY0bcqbp0hAQzaNwMm5XOLJyayOR/w4t
         BbG9PjOUS9i1+lRR1kDrqA7c5NZiPMjoDQp+kpFJr0d5HdJLLCzDobM8BuFmnreKsEI2
         ErkE7l1WOH0L0j76gj4tPssOd1C2+ZtMphaqF8v0Viwx7WayCZsr6SqJkkDC3a8KrJ5u
         eCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497180; x=1758101980;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
        b=tucILxXA7gxyMj4CIZFFP084VXflkaMcS/xig9oVCpLEjhbvr370XYy2mgFtc7+wj/
         EN6aXK7BPJ/MIRF6ZE6FTVz3BfMcAF/WA0Nk+Bvaceb/FZ5Y7tdhqNv/WqbVMvmQ87FH
         PMFg8dQdjrSQ7F66lwcVB4IDvLDQ0DofCprYwn9kE9WrclLCj2OPklnjjKG0CeUXhewt
         Ewb0iz6RFa+wLKbWpTvFDhD2Eoc4gYA1UPM85xQ35NO8Xx/bVToX4838cJK1pDCZIQSa
         yFSshRGKqkENpTHphUG+x+KT3m6IcwDKKrU2q22x/EZD+ZBe8BDMtGdMWNE1YW6/asUg
         3aog==
X-Forwarded-Encrypted: i=1; AJvYcCUtLHM9zDlHcRP872pUf2HKsu0yjTTFAUpN3EWqR4NOTrlB6ibQ3u1pVGwKqysArikwNA1+EiqB1Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lRaQu8ervgoa4I4lsL6IFiZxHfK01+hzzyh6hpsbq0vtq35E
	L7FEZIUx6ms9TimIJhnWVoZF3T2g7WbnjyZxiUorp6/QHbqQgoh83Ci6v+4ocKZdG6M=
X-Gm-Gg: ASbGnctr4df6gc7z3wQdMSQiwKVDDzW11zsrsyf2RTowMDTSVAx0BmqGyQQI7bUUoTV
	wF8XWpr90tFIOa+AOzej6bete7m68/2cBiLVak5TLNAQlVRcp64qsRMvDuv2PLPGccOl5U714Wt
	4i6KuGYAEODS5seFMY39vWJjsdnE+fYvkS2o2xh2JBHyfvFXHPoPuKzY8E3mbot17tQ1EfjgHnd
	Ck3N/hIeTK5mAsJXOkcFoUE4QGpaaLnYpZObqEL1vsbvNqau3lTWqMmuV3BEd/Tzo50iCb7mYSk
	f0FBqry+57fksnVpgnSZ761HdTd9O8dDwE52ApiUfqCJbaMuoOvpdOMrlN9zUFiKmNOXBFkpVM0
	ojjhMz4x4MrybRoKIPzKbndYOXRIr06a52w==
X-Google-Smtp-Source: AGHT+IEgLz62atvGYTtgWhK0IqE5DaeMbopSvx9UyamfacYq3cpWns33qwgJoigjRNFokWLtUFrPnA==
X-Received: by 2002:a17:907:97c9:b0:b04:1a1c:cb5b with SMTP id a640c23a62f3a-b04b13fd491mr1455086066b.7.1757497180392;
        Wed, 10 Sep 2025 02:39:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833ac0c1sm138008066b.84.2025.09.10.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:39:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BCED35F82D;
	Wed, 10 Sep 2025 10:39:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: <andriy.shevchenko@intel.com>,  <harald.mommer@oss.qualcomm.com>,
  <quic_msavaliy@quicinc.com>,  <broonie@kernel.org>,
  <virtio-dev@lists.linux.dev>,  <viresh.kumar@linaro.org>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <hdanton@sina.com>,  <qiang4.zhang@linux.intel.com>,
  <quic_ztu@quicinc.com>,  <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v9 1/3] virtio: Add ID for virtio SPI
In-Reply-To: <20250828093451.2401448-2-quic_haixcui@quicinc.com> (Haixu Cui's
	message of "Thu, 28 Aug 2025 17:34:49 +0800")
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
	<20250828093451.2401448-2-quic_haixcui@quicinc.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 10 Sep 2025 10:39:38 +0100
Message-ID: <87wm6663z9.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Haixu Cui <quic_haixcui@quicinc.com> writes:

> Add VIRTIO_ID_SPI definition for virtio SPI.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

