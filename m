Return-Path: <linux-spi+bounces-4323-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF26395F8FC
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324F9B22526
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E786E18E058;
	Mon, 26 Aug 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VEONzkWJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04171991A5
	for <linux-spi@vger.kernel.org>; Mon, 26 Aug 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697006; cv=none; b=X/8QyQ99F3AXlD99Ri3fxIlFQrMz0ZCZAii4KNigREam7QeOHbRNs+cqBdhJXt1sIbgMa1GyW+GnbJcZ+26H+Ws4kvxxJWcy13ZQEVGS4syumoPymVE8Q4ol2nALO/ZU7wjtMJzKKqc+qnaz7LEJSjApiQNfrFrc5DJaGFVoCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697006; c=relaxed/simple;
	bh=+04l99NAXXKvs+VMAqdZu3vkpDP0AsPzda+mS2bwvMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez2GH6QbUT2htovJmN5TAh06ACFLPYJcoTBFP7TtoVCnvU+lOJzWZpvAgIuBq1fcgKeSGl11G3kJRRT57ScPoKCNQFoaZQC5TwcNFQmHWgPdsYHt36wf0uCoUINUANJHZDhViaWSsK3iABScgwJlkJAkEG+ZpdEv7ghdw0pnJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VEONzkWJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so3183156a91.0
        for <linux-spi@vger.kernel.org>; Mon, 26 Aug 2024 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724697004; x=1725301804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0uuXq8ne/yMxydWV736DEq+0IEdJmv6uA08FdC9hrU=;
        b=VEONzkWJiubMOyLILLwtwUO7ovOrTWxWtJExZx2MaIUOVHEkTC16VejZ9QeFMn0Z8Z
         OyowA40sCZy7tJeqfDiiacTGBN0/TD3wTHoUCwGCS53g3Q1yGsUea4Xod6OW2iPRiXCz
         pHSk8R2sxiO8tqA/hie3Gf8S68FkbA5NaU2jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724697004; x=1725301804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0uuXq8ne/yMxydWV736DEq+0IEdJmv6uA08FdC9hrU=;
        b=Vn4Asamqt5WtDI54aob7Q5OpUsUOVyvEZ1XvJYAKqCOT/XKWkjegq/p3fJhnyuj+gE
         Qoms6ys0qmbxtwAQWr1GoFw6eedyFwx7J7cZNEhrwbtsmSWpWAXHhYalQvwx8sofk+Gi
         pmsin/jkSjb78JV4KUcUdR7KwPvYDy493KJlgivDua2Wj/JMhv7D2WE7tM/Lz6r8Rzlh
         UDyJpReKCKGxjQiCaZ44TkoBA2BbhTKW3sDsr+zCU5PQVgKecY3gCzyb5zpdUjWiCM4o
         8Q37PWAT7p3ugvZYrEeh10gxxuxr8KHXnvfwnUKApQgRcd9jDgw/p1UGZsv2aY7n79JN
         6t5w==
X-Forwarded-Encrypted: i=1; AJvYcCW5zHHYwu9UEXDSZGA6wZ5SK1ixO5aMaifYYLEuY1d1xNEZbCiXFBjQIIDttky6TJET4mdvvYi/F4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2hWK5GPHCJHYHTwIA/ViXhYdQN8MWdwveJrqmUE1nPFCu4az
	SCRMwgHtgo20qLu2IT+UbwYNzazh3m3Rvv0tA0DgMnWrNUauR/tBX2hdkOM02g==
X-Google-Smtp-Source: AGHT+IGwPAiSI+HmM0qi9NyJaLRHnGBHYsOwZ8N24Jvfmpi8hg6hXb+xyDInVkOXA4sv4ynq6h189w==
X-Received: by 2002:a17:90b:1c8e:b0:2cf:f860:f13b with SMTP id 98e67ed59e1d1-2d824ccee69mr757303a91.17.1724697003957;
        Mon, 26 Aug 2024 11:30:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:7e40:430b:848a:1da6])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d613941e79sm10220036a91.25.2024.08.26.11.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 11:30:03 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:30:02 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jon Lin <jon.lin@rock-chips.com>
Cc: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, broonie@kernel.org,
	heiko@sntech.de, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengfei Xu <xsf@rock-chips.com>
Subject: Re: [PATCH v3 5/6] spi: rockchip: Suspend and resume the bus during
 NOIRQ_SYSTEM_SLEEP_PM ops
Message-ID: <ZszJqpj4_8yfRwTu@google.com>
References: <20220216014028.8123-1-jon.lin@rock-chips.com>
 <20220216014028.8123-6-jon.lin@rock-chips.com>
 <20220621154218.sau54jeij4bunf56@core>
 <Zsj_CJR56TcahXBO@google.com>
 <f836c6fe-3edc-4e6b-aa83-b50d9edcb816@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f836c6fe-3edc-4e6b-aa83-b50d9edcb816@rock-chips.com>

Hi Jon,

You sent HTML email, so it likely didn't reach the mailing list. There
are some tips here that might help:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://www.infradead.org/~dwmw2/email.html

Anyway, I'll quote what I can in response below:

On Sat, Aug 24, 2024 at 01:42:14PM +0800, Jon Lin wrote:
>    I made a submission in the community, and RK's SDK processing plan is
>    to
>    make compatibility processing for PM runtime and NOIRQ.

I'm not 100% sure what that means, but I see you submitted this:

https://lore.kernel.org/all/20240825035422.900370-1-jon.lin@rock-chips.com/
[PATCH] spi: rockchip: Avoid redundant clock disable in pm operation

I may give that a proper review later, but I might request you take a
look at my patch in addition or instead, which I believe is simpler and
clearer, with a better description of what it's solving and why:

https://lore.kernel.org/all/20240823214235.1718769-1-briannorris@chromium.org/
[PATCH] spi: rockchip: Resolve unbalanced runtime PM / system PM handling

Please let me know if that patch works for you.

Brian

