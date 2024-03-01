Return-Path: <linux-spi+bounces-1610-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE086EA8A
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 21:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCDC1C22C2E
	for <lists+linux-spi@lfdr.de>; Fri,  1 Mar 2024 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAAC3E462;
	Fri,  1 Mar 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QhBpF2Do"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333C3D997
	for <linux-spi@vger.kernel.org>; Fri,  1 Mar 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325955; cv=none; b=c0Klu2ltopHPvF3z0QC/XtTMaONB79DgeuLw4pC7iu/9fxw1IepvG9SP25K6xlr/uGgFUTbxdMtz9LqzEXRrs/D2o5KaGkmgmvM7CGO+wI+Eh3REGaYqer7tT3FJa7uUDNoc8h3I/Ex93zEIRZt5Cr5vNxNepAWd/a7yxq2vnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325955; c=relaxed/simple;
	bh=L1mnju6b2hWfk4qgJMRiUjxIH+2I4aVtoC/+dDgCUDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jodL9JXDMJQDPltP4HiYktohyjtCEtsB9cmPvucGo/Ajkh4myNX13zplKQLROUKoWTw4wgbe9jx5OyJhnt4YReLIeP1vAwgp4SSLYBcXl8aXHcoAcehqItvSBQw2t7NXev0CNBm5DCG9nbHFzXEA2hUILWhioXacmKnhPVLwKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QhBpF2Do; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dcafff3c50so21985885ad.0
        for <linux-spi@vger.kernel.org>; Fri, 01 Mar 2024 12:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709325953; x=1709930753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8hRbWiJCnr6KRmDmcx+k7mhGRkhvPSvpUDzp2pK3kI=;
        b=QhBpF2DoqIVWqzjnKB0Urx6e8xhkcdvuKCkBUK/iB6JzHaQkbWQBfmti6OcntLsj5Q
         22KZO+E6zokXeaSzADTynGBeS9IOp4/7HkOTnwrd43V3lQ9+23vumfpg5oB+VrviwomM
         wFMALhe55PpNIKWFBnCfd+dPiXmIJ2kQgCsIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325953; x=1709930753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8hRbWiJCnr6KRmDmcx+k7mhGRkhvPSvpUDzp2pK3kI=;
        b=VLZ5W2tv0Up2u7jfu2cadL3zoOqxEw4oF/0zb8X6xJHVU9MvW/7vmrO82ctIA5DixP
         TgXVhSk35DtldwUXP0UjEcS6Hgoj5L37P5KU5xzJrV01chRbtjN/9zByhQ6OievB4Dlb
         VzGga2QLUGmH16IoRZNQcHWzsB6sx5Xs1CxI3wkaVREzWFmHwBTolnOudP8+ykWsmD2e
         6MVH5gqQIWc3/v2L9jJbV6zcT2xw4hn4ou3UK0gnT+kvxGLsht91KZC5qWc0UmaShqg1
         m1NAt13CeYOQ6WFSg/914oaT1le1fGemYxfcmYWkFt0py397JPUP2uZRQBNJ5Fr4hidc
         2qvA==
X-Forwarded-Encrypted: i=1; AJvYcCVsOkIRTW7tFh4xpOoUkZ+3GAHHwLnG6YzEJxpoukl265UqfRPOvjja0kGZ+RqgnachPYOqGtP6WeSECzmUs+uc37h5k1pe9hQv
X-Gm-Message-State: AOJu0Yzf6okyD4VWHoL0JE216gJU03Rsr2ZPuO6g0H+/TyvUAG5z7qp+
	QBk5C2fDEyryHhgAdIShnQcPcPOTrQiTQYO1rBd50y23hjqKP3H+s7lOvQhluU/cvRkTM8ekRVs
	=
X-Google-Smtp-Source: AGHT+IEeHOtGROSfO7InBUOVtUOBB5GkfEa/BvdxAw10MRzeVk4FVzrKuCP1P98bzAscQ3onwNP8kw==
X-Received: by 2002:a17:902:c146:b0:1d4:cd4d:923b with SMTP id 6-20020a170902c14600b001d4cd4d923bmr2488161plj.54.1709325952968;
        Fri, 01 Mar 2024 12:45:52 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001dca997b3e3sm3892081plf.65.2024.03.01.12.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:45:52 -0800 (PST)
Date: Fri, 1 Mar 2024 12:45:52 -0800
From: Kees Cook <keescook@chromium.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 3/3] spi: axi-spi-engine: use struct_size() macro
Message-ID: <202403011245.3BDA347@keescook>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
 <20240301-mainline-axi-spi-engine-small-cleanups-v1-3-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-3-241dfd2a79f7@baylibre.com>

On Fri, Mar 01, 2024 at 02:25:20PM -0600, David Lechner wrote:
> This makes use of the struct_size() macro to calculate the size of the
> struct axi_spi_engine when allocating it.
> 
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

