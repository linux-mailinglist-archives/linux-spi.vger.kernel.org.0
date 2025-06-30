Return-Path: <linux-spi+bounces-8922-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 629E9AEE655
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 20:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8B63E057D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED212E7176;
	Mon, 30 Jun 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9RBEbZ3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD2291C30
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306413; cv=none; b=mWWIk1vf5kZ/eVqOOUh41nYJ2b5HjpxrbsrrrwzGM3Q7eP9HBHs85WNfhvBli7dR/9Ycia5NLg777l90wfEnyBOGY52y7GjDlZH0BANSk5K5kNCFJqeDU5OpG/ol3IHnTEKIKDxoumszxEZKu2RaAOExyl6Qc8hKzjQHBLCFevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306413; c=relaxed/simple;
	bh=aSCHYql6Y1v5C4+ckQvyy36V/kDIghboE3pXy8frVRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly9FgPfG22NNWbtsKPVV1FdJqvZWwI99tRPtgTMGWbWZrZSWRI+gzCfSI53VIvdZDAimQKNK5WjwuUarj5WNnAzecNlFxmxFuajuqiFGwAGIZOzHhMZyozXgQc6HnHhfvLseQLika3ywyC1Bi9O/D3Q0HSbGQ+Yx0mfy0VRqLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d9RBEbZ3; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-40b31468da3so441352b6e.0
        for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751306410; x=1751911210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nP34edbHBs8vVR39DOc2sWEr/hY8CPswI/lDfFfduJY=;
        b=d9RBEbZ3Z2HTOncxmVxO31hkLJFGbotpjo4SvXDXK/NyTQ+GN7Y8ynfOCP7v/itRAi
         ZrhmI9+6y0da1+cmY3UemPiRiomNgwLuobyDxXVTp+xu9A/vlk4Qf2YgXzlcGt5XIMPQ
         FW3E6WorhdcM+gyNvbOsoqC8Li7rCuFPJnHeK6tjgR1eSejUJAnHj9XsI6W7xshfyRAr
         lgbCy5oTicDixNFoJf4+uYRhzdMKTvSNg1TxNROGHBUdet5rbUhIGBEM7RmYhbsm378t
         1B8QKjvxsTbD42jCNuQ9hsWBp69erl8ZQdZNCT9ntFN1CePWc4/C5xmXRHLWhfid07sa
         /TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751306410; x=1751911210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP34edbHBs8vVR39DOc2sWEr/hY8CPswI/lDfFfduJY=;
        b=kpG1kKkDXIzdKqI9cXYDAS4VEAKgBcku96gjtIDAdps7ydS3T1/UDgJEgnNdUK7U1D
         eLaO+vhpwRjHK43C5vF0jae3R+9bisUUg/zy+1sINZ6WsbU3qQUQs9Cl8FOAGbueXiJF
         mf8V81ktZC5iEIzpL+cKt1tiBIYbOkBo1CPwvuIYfuzc8hi+1zy1EJ7G0DGRFtes2/0U
         o1UiVABQdoc2zUnQ5Oic++Ritw9VQEL9oV3gWnQXsDX5+8P5GQCkT/cnd0L+YDduAqmf
         G9H6FNuknUZTUvj+e9Tbs1pF/toH5h4TlD1lalumxktZQSLttXqt26FgdjDsw06Yd4d6
         JGlA==
X-Forwarded-Encrypted: i=1; AJvYcCUxsf+xnNLx8WQx7/Nh8L5qsfhfNWDD7SAn+FaIPG6xS700cf6HubH+/yPqzcG2kclDYfnArc+LkIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkNqQDka/CVJLEIS54nap38SsanCNH7clE+qhW8HpbOBB7NVBN
	H3cTqPPNLm/xoid9g9Kjy2Nj+JhEj4wir5WnxIUMBKlR92uxszBx2USD0Br6gwhoKmw=
X-Gm-Gg: ASbGncvc9/LG3l5zpMzguS1wgAkd0ukoxQKUE+tn0Yqz9YSrQK4fY2kCNwTggFttYx3
	QDfhMZXYeG2iytsqj7HMuIj7z8ix7J9U89JvmdWloYE//qVn3Kcn2OCROiitAWbrLznWmIoIK/T
	uc12pqoC+/4cPSDgvO91VaeTEHp2MV+4FCQgNytPlHA89uCq8gEbGizQbbjeGumhw6DIgqZnxFj
	mJT7b2eV8jOOjpzoIJDUPmirS0vCr51IroEezj+YikhbtuVi4BW5FgVBgNNUtvJ8c4S1rj0wPpA
	Q2ryxHMU3Nlhx9sHJ203lGHbwMhG9IznEDmAHYHL8SOcYS0id9tQDokc/A2HiG9T81wKkIMuJ34
	j1N4=
X-Google-Smtp-Source: AGHT+IHLNzdJg8amBLq7uFi/dLCM7igqScX5Y3+a3Y5i48QPaQrERmo4dRGF7JEEecfpyhBamvzphQ==
X-Received: by 2002:a05:6808:18a9:b0:3f9:4f55:a002 with SMTP id 5614622812f47-40b33c79017mr11035935b6e.12.1751306409807;
        Mon, 30 Jun 2025 11:00:09 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:fb67:363d:328:e253])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b364ab73fsm1657127b6e.1.2025.06.30.11.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:00:09 -0700 (PDT)
Date: Mon, 30 Jun 2025 21:00:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: khairul.anuar.romli@altera.com
Cc: Mark Brown <broonie@kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH 1/1] spi: cadence-quadspi: fix cleanup of rx_chan on
 failure paths
Message-ID: <9f26f205-756e-4fcd-912e-bf73167be21d@suswa.mountain>
References: <cover.1751274389.git.khairul.anuar.romli@altera.com>
 <89765a2b94f047ded4f14babaefb7ef92ba07cb2.1751274389.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89765a2b94f047ded4f14babaefb7ef92ba07cb2.1751274389.git.khairul.anuar.romli@altera.com>

On Mon, Jun 30, 2025 at 05:11:56PM +0800, khairul.anuar.romli@altera.com wrote:
> From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> 
> Remove incorrect checks on cqspi->rx_chan that cause driver breakage
> during failure cleanup. Ensure proper resource freeing on the success
> path when operating in cqspi->use_direct_mode, preventing leaks and
> improving stability.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Mark asked me to fix this and I wrote a fix but apparently I didn't
hit send because it's still in my outbox.  Sorry about that.  :(

regards,
dan carpenter


