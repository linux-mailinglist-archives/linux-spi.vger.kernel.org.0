Return-Path: <linux-spi+bounces-9963-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B594B512EA
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 11:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520771695C4
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 09:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7123148C2;
	Wed, 10 Sep 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or5Hcgov"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034C2DD5F6
	for <linux-spi@vger.kernel.org>; Wed, 10 Sep 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497390; cv=none; b=Bl0TY3QL6yETNJ7FOLfg59z6wKbne/WzX796ic9f6xrQN5qi/josgGJ9iggoAPrzcps3kvJieNqqvDr0eAtkUf6xiecx3LhNdQm03G+YkMfjpZqJWygLz6OujqcmuAOK89sxpiylqYas97VkBpPf+wQ4FTGQC+uYgXJLU2h/Gwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497390; c=relaxed/simple;
	bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ParOLilVH3TQbfQuqbIwmbm8fx4Hwc3A1kicDz5Pp49xxSvsDIvsukA0WzRe6c+CsWv5mX3vzeCPueU9cEruWiqYCBYu38oqhfpJdqJp8R4Mzs+ueq4TyVFMB0m2ab+/sVc9N/dFk4Maxc5Sv0xO7BFuAH6R5q/hwDKHP97blEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Or5Hcgov; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so7978285a12.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Sep 2025 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497386; x=1758102186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
        b=Or5HcgovTKy/+IdRILIG/rLTDfpglBw4XR2hYP0fBewGlv++OuOajO7F5raparnW0q
         q9LaTzIcL8fPvtgCq0s8dAzWs6ZGkZ1a1vtXN2pYq2nbpy8A5pEG3qvrBbk0Z9MiXR/A
         2ZLd9t0UQKRvjJ7WTQLBAkNO+IWNfLu6aNaa1MJ68PU2X3iRM7++lEZOIMmzFWcN5aio
         1iYR0MsYR5ur5DjJC28BjUPMDCfpBlgmlX2pWxC9Ye6iO3ss4Z/YLbFr635UrJ1PN6MT
         MzpEJrKJtoknIrcWAaWFxFO/IoK8WkLMJOBwuISkZ3Uf8/ubfl3xeikHgyXO8chXlyzI
         /sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497386; x=1758102186;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
        b=UN2NilXvHC2Odm0Zt1ue8HzSEyVlp80pT112udoReWVRrHu5z1lsImkw2n+8HvxG0r
         MfAGXlP0Wnbm9lQIOQQkpgN+Bid50zPhLl+fXL+sZuR8WO9mD14QXgmkzJ9zusTVRuzK
         ARyc27Us3L0dM2o+RkDZ2B8wmwBwER7cTVAzoLMQYHXVaKSn+Xi5P0DyHyAY2xESTykb
         lwvsVNh4BvuFFfMLVvuUNJ9DTnrbomkvIAM233W2XUrr8WfPxIAszP5nFaUzv7Mq7Cfc
         jUiTSCvcmVbLN+6GcdjjeHu6pB2pEVVv7djbaXZRBjzleBr4modKXL5t9KUTWDYisCJJ
         tSwA==
X-Forwarded-Encrypted: i=1; AJvYcCV28A7DUXBW2y4fP7QBwE8GNOGR+XystChDZtRQiEExexZxz3rEZCfx/sZicKwfNukAOar3fd21qMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFdgy6IxBXc52I2jBNHhZg7yeIjzsLaZw0zIqdBUlqTC01+yM
	6CxX1dGsxNqH42J+9wx4VXWyhVQBhTrQYvkSVPsLat/5CRQsHeJ7knz/ueG7VYTH66rYXeQu7Vc
	q3k+FTj8=
X-Gm-Gg: ASbGncujEjphD/ZYenAB2JPf8i519fVENJfrs1t8jQ1yQiLmf7qtCJeHLDwryRPijjs
	kQLTVnftHxWUfceVJe06FBSxWjkkyI5Rah56Q93MDGJrXBddKyorKuqTKIHcHN3of9nwvK7nrRa
	aYQNuueP9ue0Qy2QrDwBmbt2L9qaNRj5TKI46qxQoQb3EL7Gw0QZRzloN+iF7pkE8ALDjkYamFJ
	GtOgq/3rn3aJUNUyRet5jGCcoZIwfKN+NnrM/FHJ8pZtWHDGSr+AsYBrg5O5p6hIO5Gvfpr6YMj
	NFmlazTM/OMNr7I5b+Ysp42cuTM5p5/t0Rfu8m9YmBVWUkXRLR1kiV6qeLvRI9kLOjJsxk2aSqa
	lnyZJTkPhTWzzZx0L7IVQ9ow=
X-Google-Smtp-Source: AGHT+IFWuLSyNubOEP+haT1kxcJlsnbQvIZV9vTCdS/TLhc04cY3/upnJwzgMXGylHLDI8GWpEssXw==
X-Received: by 2002:a17:907:7f93:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b04b145f591mr1268961666b.9.1757497386292;
        Wed, 10 Sep 2025 02:43:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830bb83bsm136246666b.42.2025.09.10.02.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:43:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BC8215F82D;
	Wed, 10 Sep 2025 10:43:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: <andriy.shevchenko@intel.com>,  <harald.mommer@oss.qualcomm.com>,
  <quic_msavaliy@quicinc.com>,  <broonie@kernel.org>,
  <virtio-dev@lists.linux.dev>,  <viresh.kumar@linaro.org>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <hdanton@sina.com>,  <qiang4.zhang@linux.intel.com>,
  <quic_ztu@quicinc.com>,  <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v9 2/3] virtio-spi: Add virtio-spi.h
In-Reply-To: <20250828093451.2401448-3-quic_haixcui@quicinc.com> (Haixu Cui's
	message of "Thu, 28 Aug 2025 17:34:50 +0800")
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
	<20250828093451.2401448-3-quic_haixcui@quicinc.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 10 Sep 2025 10:43:04 +0100
Message-ID: <87qzwe63tj.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Haixu Cui <quic_haixcui@quicinc.com> writes:

> Add virtio-spi.h header for virtio SPI.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

