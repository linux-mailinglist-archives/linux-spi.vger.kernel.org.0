Return-Path: <linux-spi+bounces-896-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98583FE69
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jan 2024 07:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDBA1C22499
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jan 2024 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F64A51C3B;
	Mon, 29 Jan 2024 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iM9GuFvR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62C4E1C1
	for <linux-spi@vger.kernel.org>; Mon, 29 Jan 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509853; cv=none; b=EP/o3iPMWt7N+Zagc7ULQTSCb9uzO5f9Ef08lkyzoZ10FJ0oSUiNdNgrLHKwfG664rdqPdCoRepb3fhcfWnSZHq0WB1jsK6StqsYBoXJfOmEJzGdsYf7how2RkjPmFoEU45dvzA5Xa7wgitTNu3m5AEKcRlNTB4IXMVnaKyaJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509853; c=relaxed/simple;
	bh=Nh5fNbqnzNpSKk7yH37ydnGyv3ul2OhY4GvbMvtsgNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGCWlMZtMVTlxPQCHmJDwPhPdMvQsdjWzHxURw5l3h6jM67UvzJi7vyUI2FWCl6ou9ASR2w6OVGN93mB2XMyJzB0SxTfejpP68JyHZn5khnZFHQWkiUhwxtNtDaYGleR0p/PZUvDK9brQCRYvmAdb/c/byg/NFAtkaG31XxetnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iM9GuFvR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2039699a12.1
        for <linux-spi@vger.kernel.org>; Sun, 28 Jan 2024 22:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706509850; x=1707114650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcNcTEhoIWYD8Jyza8FT+m6h2KJ7pAuMT+sHRSLuWk8=;
        b=iM9GuFvRGWM71YvcjnJw73gMBeFJ02MIWov/qaO/lfKNjVs5sAcyysdah//jOwBJXT
         YIvGHDfqWqk9Ekj3dLK35tlkc0RZMakLM6zUIY4JlgT5IOYHZz9wdiCrWYm+5V2sk+sw
         iYNtEwH+J5m+DmYwssrWYb+IMDxM5P2tRxFz+Mn8mRfyHzVuAHdSKTresAhdMsp0Kf2N
         D1OZJFgTe5FR4v0hwj8Wb9JUSrpyL11XnEzrlUfsvZT+9fEtHiSqiC/J8bafQA/rLs0x
         AXUZ/L6xalpzxTF/Gu2aQWdApnN+kIZfx8vlIuyUcmSbM1Rdml6Fuhsiwymr53iEsDWZ
         BucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706509850; x=1707114650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcNcTEhoIWYD8Jyza8FT+m6h2KJ7pAuMT+sHRSLuWk8=;
        b=Cwj7pt84jJKklm2lc7BMvoZ/pyhRQSv5ZgVAE2zqD60QHJpppxLUb3t0dKsRJp3SJP
         2p5zzcNX8mwhFNZa9TzP869xhK9gytAQbFGSonnd85LEYsCxVsT8aN2RRcEZlEAttpMY
         glIbH5/1V/0fI/c733VbYiQpQ3tjgvlHo2JZIN8b/BNrz61v6zrNkpV/Y82c/sZVL8Ab
         cSBTzRMmW2h7rr0s4U92zFE73nnWqNMe8zyrq5k5TSNltfNR/DUU5OwaRo0wO9/jvGQT
         Ma1vjOUD0yxSwNRvpsPoP/bgWBSVXKTz/AtVK/LOS1oMzj71C+gFIJltK8hfAaVl8uxh
         TUpw==
X-Gm-Message-State: AOJu0Yy5yzlBM4D3wDmMMqVZhho1xf7QPZEEf0Ne6BZj4tQwsbGV6HPz
	wVZnVZ+O86VhsZ7ZzxJ00pNbIsyo+tpYyYvqtWFXPCUq/oLf7PqZ7oLfsabqDO4=
X-Google-Smtp-Source: AGHT+IGh1h+05vCnmj809KQhjvUSTg1qxRaQJCyMKHLDmh1e7V1HvPMklyZdkqrrztZ7SNswfm/rew==
X-Received: by 2002:a05:6a20:7f8a:b0:19c:71bc:ec82 with SMTP id d10-20020a056a207f8a00b0019c71bcec82mr4830387pzj.48.1706509849818;
        Sun, 28 Jan 2024 22:30:49 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090a088f00b002902076c395sm7215305pjc.34.2024.01.28.22.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 22:30:49 -0800 (PST)
Date: Mon, 29 Jan 2024 12:00:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [RFC PATCH v2 1/3] virtio: Add ID for virtio SPI.
Message-ID: <20240129063047.hgnljeqq2xswoteh@vireshk-i7>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
 <20240104130129.17823-2-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104130129.17823-2-Harald.Mommer@opensynergy.com>

On 04-01-24, 14:01, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> Add #define ID VIRTIO_ID_SPI 45 for virtio SPI.
> 
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 7aa2eb766205..6c12db16faa3 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
>  #define VIRTIO_ID_BT			40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_SPI			45 /* virtio spi */

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

