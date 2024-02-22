Return-Path: <linux-spi+bounces-1461-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217FA85F514
	for <lists+linux-spi@lfdr.de>; Thu, 22 Feb 2024 10:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D4F2824C4
	for <lists+linux-spi@lfdr.de>; Thu, 22 Feb 2024 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D6A38DFC;
	Thu, 22 Feb 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZXS7qfU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC03770E
	for <linux-spi@vger.kernel.org>; Thu, 22 Feb 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595725; cv=none; b=LaPVYfk0rlRFAcyyKBU0SisxkpVYXoSJplKHxaWHwyiuGfQ8uSUkGdeO26CV9synlWcdqzEtcjl1f3fvRP9mUR92V4OjGXcvpyCB0vE/I3rASAvEkCfO+PyyDyOi+jvhPgEXzJqbwoo5YQxy5fVl9wrGao0PbRENbT7Jg5w+UsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595725; c=relaxed/simple;
	bh=eV7rTjQepxpRnQDP8ZB4CGBrul90QIFvGhK+2gQqZ5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjSlP+IpWNrJRyBHczz6STaaHyqIMZuqoeWOSLBRkPScQruOfZ6UgNi1DqBgwZRkoqBEhwXzr8Arj5T8EGFRXkdRIwlkafUAVUmxuDVK9BA/6voThB9UQV+KrVTGSw2C+lJ8b8TWScm7vXB2PWQ7tFZzHrp6ibNkWFKT2BaG/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZXS7qfU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2909978624eso4607494a91.1
        for <linux-spi@vger.kernel.org>; Thu, 22 Feb 2024 01:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708595724; x=1709200524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eV7rTjQepxpRnQDP8ZB4CGBrul90QIFvGhK+2gQqZ5A=;
        b=jZXS7qfUxNot0SYKnymJXKsCHpn3F1ttCDseIs4zEvFNIOQ79i+pKWifit+kuieqoF
         E57w9anne86z8fzAJqOUXONh6qvYMpihImp8Rk/bzhblWo9tvGfyY9GSr8t+Mx3LdvzY
         vnzV8ogQyoe+N3xtyRcIM/+gK4xtuqIrilii5tnseElTk0ZSB43ACshMc91uCQg3g1M5
         XSqcLpTY7d389j2+tAnarlR1WUwlJTZbtam9XDliUFez8b0/rAeallnyNQmuBzHDMB7P
         cBnVl7dTNJqjS44ih8n1zqt9G32OI33iitDUce9euHXu9P0fy9HmrvBo8BrKmaa4oFh4
         0rTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708595724; x=1709200524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eV7rTjQepxpRnQDP8ZB4CGBrul90QIFvGhK+2gQqZ5A=;
        b=iU3WhBZc6SbYjOv3C4FsUEdEKkXUNX1rXeySoe/kEu4BqZ2jBM1lkkkmQ+R8rn7I+F
         LJxPY6SCiN5CI+VH6vJ86u0X+8kapF+58N/wJcSQlTN7DdGaKEt8hxaw6EvWfUFh6303
         palSTftkupTHCX5SS5k1duwo+FvSppg/oMRAG2tmJvuqUnvUunawxVhQP4eHWkDi1yPA
         lF+UmfXqpH3o6GZfHcERRu+QmVxfGvRHWVO5qsNiNXjBEiTwJ+PgBWKavj+0TKENxg1b
         Jfw6z3Rg01gy40mMfUJ3qvJRMjdZ+ImX1/q/GB1hYSUC8oRreqceGmCWlicheZcRuqSP
         7RjA==
X-Forwarded-Encrypted: i=1; AJvYcCVy0yIBazdhyy+X4JHcobWDhfWuYhNrddLue1ks0Ce9s+/nBiZfenJ6zpHCW6+pF+B8I76o4696D45mlhLUS7gdwPp++s6cxCdL
X-Gm-Message-State: AOJu0YzcSKe5S8bWUIaFmZoHlrlOH2DAboffjsejM1skBlmukxFbmW87
	LepQDyhtmT0cLsBDYngqmzH/wO8cBxYdzZPRcPk3b8I/lhQ4u3R8n4on88toH/3i4I+bYL1goHF
	rE1EqGuqQn+906I8T4ikgdAjv+qg=
X-Google-Smtp-Source: AGHT+IHLz+wfLZXB0YHFucWdo+7FnHBMr1ojJ2eMwKRBvswE1kGZqkyZ3NW1NgKGkliVjmLhobKy2dHSoFgD8cOq8p4=
X-Received: by 2002:a17:90a:8989:b0:298:bce9:47b4 with SMTP id
 v9-20020a17090a898900b00298bce947b4mr17359396pjn.48.1708595723772; Thu, 22
 Feb 2024 01:55:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com> <75a22482-0d2a-4e0c-86e8-3a8e71f2f403@linaro.org>
In-Reply-To: <75a22482-0d2a-4e0c-86e8-3a8e71f2f403@linaro.org>
From: liao jaime <jaimeliao.tw@gmail.com>
Date: Thu, 22 Feb 2024 17:55:09 +0800
Message-ID: <CAAQoYRkVYjs_+7cSc5oU4qKoi3_5My8xk32RWq3O5V5D_xBg0A@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Add octal DTR support for Macronix flash
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, 
	pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com, 
	richard@nod.at, vigneshr@ti.com, broonie@kernel.org, leoyu@mxic.com.tw, 
	jaimeliao@mxic.com.tw, "alvinzhou.tw@gmail.com" <alvinzhou.tw@gmail.com>, 
	Alvin Zhou <alvinzhou@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"

Hi Tudor


>
> Jaime,
>
> You're so close to have these integrated, I see there are no major
> comments for the patch set. Would you please address the comments and
> re-submit?
This patchset would be take over by Alvin.
Thank you for always giving useful and kind advice.

>
> I plan to do the PR next Monday.
>
> ta

Thanks
Jaime

