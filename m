Return-Path: <linux-spi+bounces-1608-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C1186EA74
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 21:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3606928B835
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 20:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C980220DCD;
	Fri,  1 Mar 2024 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="knvWd5hA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9863D995
	for <linux-spi@vger.kernel.org>; Fri,  1 Mar 2024 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325729; cv=none; b=g+zw7CAEMR/aiDGQblBSC4iXK7ph23j1h+Kr5lnzwaPcnRsJR2pAlZtd7L0mG+rPEX5qjHdlLHS5MmO8hSncYNW515z5GhvdhFXEBszhxr1+oEcbkKt9mJwzjCP6xrdRl6L/WCiwDA1XBGvu9W5vx+xmATrvWvnSXYzXkxMp3y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325729; c=relaxed/simple;
	bh=0fhuNSDX54Sst9GcjEyXWR9CexJHgJMRh1Qzt6BCRkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvQuJ0rzlCPQEZm0ALS/7muE73lyYMGUgTCtdxnwpmP9eT7/NNGIEIi3sxA9tRwyvyrxNxAdhFzVQdQtsh+fjo4cghnoHyov5P/Bi8x8K1y+57QzJU36lnt4cXFbhIuKINOp+RaKv4UzilPrB1lLr+4gEAyUObFOj1TdZT4mJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=knvWd5hA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d911c2103aso9399995ad.0
        for <linux-spi@vger.kernel.org>; Fri, 01 Mar 2024 12:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709325727; x=1709930527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9yZ/wvCDmHKXxingPVnUfxmRxohhXJOHZFReqLyClyU=;
        b=knvWd5hAWjzX2Et+7XWtXd2GPBDmPpk41CvVahWLBQ/F6xsFtQ0Za+wsCaURMEbZJl
         8bZLFjTDhhRVVeS0TZW5H7J9iUBMOVqsAUnvdkYiH6o7hyu+liv9IWlaMm3I9EzpIHzX
         OJ9Y587s8inOGyf7hZ6Ly5YkrlbKxsGgvp1Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325727; x=1709930527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yZ/wvCDmHKXxingPVnUfxmRxohhXJOHZFReqLyClyU=;
        b=JaoQYjUPFXH6gKeXYB1YqKf1s/wJ2hcPOEiu8m2j8SktU8DUYB7Anu+y9rNHjin8LU
         53eXziHmbZt+gUGhTyYAha70adiXplSl9fix48jIwjv+nbb9XyN06gtGTzBE1yzzOy9R
         tQwMWMfh88F1OyjkxWrVf4s81R4ao5v3vmAZGkVo4mWgYBz93CvRCPloBtDYs79pZp4t
         /vdPakiORZDvjSeY/SGXXtc6rd3K4ZlYaqJ/BqCU0skDP67XMW2lk36AkO390ZZvd/5a
         qAjOPltmYvQEMEV32MjX6DfajU2pcJbMv6B3yxTZBhVohBXf4uMZ9LkRkamaWtG0nZzA
         1Fmg==
X-Forwarded-Encrypted: i=1; AJvYcCXUhTYv2Ib+VDDZ2FuLKHhz6jJVQp7XezlROQTlNL0nXpgV+7Sefv6WnFI4TPc2twm7LWc2fRsacJ5KalH6q1GsU7T6ivpSVC5c
X-Gm-Message-State: AOJu0Yx07N28evNYXvr3x3Z4aoDaCfA8u85y6F8Ra22IEjgm/CFUrVb2
	jin0itEm7zwhVgFzIOYFKoXIcWAvTVfdKuMcYmnW8CNSHFcVvogqAnNeGr+9xg==
X-Google-Smtp-Source: AGHT+IEdOQY/C0bG3YJv9E/3op7+gpy4qW3uyPZdC3FGAVXEJ3godvG4Ky4Z1kSPJMWEesnqRJsQ5Q==
X-Received: by 2002:a17:902:eb88:b0:1dc:43d:962 with SMTP id q8-20020a170902eb8800b001dc043d0962mr2987376plg.42.1709325727627;
        Fri, 01 Mar 2024 12:42:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b001db337d53ddsm3943854pln.56.2024.03.01.12.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:42:07 -0800 (PST)
Date: Fri, 1 Mar 2024 12:42:06 -0800
From: Kees Cook <keescook@chromium.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: axi-spi-engine: remove p from struct
 spi_engine_message_state
Message-ID: <202403011242.C7C42CCCF@keescook>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
 <20240301-mainline-axi-spi-engine-small-cleanups-v1-1-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-1-241dfd2a79f7@baylibre.com>

On Fri, Mar 01, 2024 at 02:25:18PM -0600, David Lechner wrote:
> The program pointer p in struct spi_engine_message_state in the AXI SPI
> Engine controller driver was assigned but never read so it can be
> removed.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

