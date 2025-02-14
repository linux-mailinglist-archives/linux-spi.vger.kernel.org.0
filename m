Return-Path: <linux-spi+bounces-6823-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA4A3563D
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 06:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EFF188F6FB
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B391802AB;
	Fri, 14 Feb 2025 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icJjvdQ9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1299138DD8;
	Fri, 14 Feb 2025 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739511115; cv=none; b=OyzR7roCNNNUEN5PDl17uVmgeqsjPu0PlYYchM0lyEJyNFqxLvlkxfIT39XP1jcSPTNUVndldexQ+8a5nOjNEot96uzt1BJiwTrMJm8yj2ts6Tprqrs5T8eO1J9OvhUe6P5z20PvOHfdcubdplg6Ey0H86DAGqVprBkPPQPZI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739511115; c=relaxed/simple;
	bh=PWdi6RI9ZpMEHCMQdxFK9SYtxmQLCjjX0rIzfCofw7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNEyRX92MrMrqcpwkgskd3OCrJ/OsefMt+QV1bgk/amV8xgvoC+Mme9imS7PCiezmBTr+o/fmZeGf8jtUHfnSM+H4TV5HHtBX8XL2uNTs8o+Wwtmla1pvsH3WY35/Y49SyiVjLx3DQ23KY8XvsjRG5QB4nKD7dVUvMgt41lfojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icJjvdQ9; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4bbbaef28a5so531936137.0;
        Thu, 13 Feb 2025 21:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739511113; x=1740115913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjd7hfsfd8muVVZ7aQvyk8gZxPAzOHt7LsUJD0zUuLw=;
        b=icJjvdQ92sSogabhlKMJ1JWRIf5b1NZrKVSTN6HdGYd+hsiyCZFhL3JpsAkv/V/WEi
         ecWD4YQMteAZotcn4AXMy5Mj3W5oUzsrxeLp2FbKQwqAmPrPr48aLoYLLwt96P+Dtbl+
         XZvpxefncPKBckVtla9XwlMoeZusA91HasxxNivo6gmlYzdPp4VMksoZgqcAax56FixZ
         thZd4ezk9FzNual6dcg4dIvEsC1t3p4pm1ht0LrE6tM1cjO5Y4O1SgpqVefnZXFYKZzt
         SfuQdQq7DRuBy0UZOFh4dQOKKxzPv7coSaTiTC3GKLVH054dSE0QSlEvS3WbMNTSgaBI
         B3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739511113; x=1740115913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjd7hfsfd8muVVZ7aQvyk8gZxPAzOHt7LsUJD0zUuLw=;
        b=HaUR9u1Dhq7vYCEAUXG3vAy9XUL8M6c6zEU5ygXtX6Es4cMAzCctBT4nRRj/MOk1OQ
         cDx/3aBfddE4AIQUX47YieBKK3MK7E0YvOuvABnMydcOvcrnS48bT2Un2+MXDVx/Vmw3
         9xCTYhyoGylAEsGBZhdZmBL2YtAECZZvWyLYCht84OjrJVemqPeMfxyfSWQ1sukxI99K
         ahJ9HdprLbYwKUFZDOrYrs2KuZSl+d4V/pKt84rv3CkFknO+S8CL7HlywVpS+ps3CN7W
         ULcZGNpCEnvGuvfEr+wvWWuRU7z31YS0YZzTCBYzGQCTFL4FfSkpYEhYB3I0kHFfWU/X
         13Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV2kD1z7XGszoMXA5oGCePs7qgYyNHby9aA1Vtr0bM97qxXaYvb3fbclqEPJp+WsIskgE4+PxrGj+8u@vger.kernel.org, AJvYcCV4wT2a2mFPNEU/YWWGyUi/GCP4LuRNOH18nILl3J/dH2ctfbzmUtkXE3nF/DMXcX15XZhaa+PBv9sLyfyg@vger.kernel.org, AJvYcCVHvFm5siZFJVVXMauNYJF3BBANbbu+o1Q7i3tzejSEBbeGFyrH4BNQPzPVt/Kkux9wZgUsnuzgzT/8@vger.kernel.org, AJvYcCVy9xF09r5Vazg+DpUAQOOj0HbdUWh81cXX4FjMG21C6GCIB+mSz0bAtPCnBFQ5IoSE1GuprXcKRfFgH6mK4m08TMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh11iy8/oVp90Z27BOdAAVLALoQubrEtwyd9+fYReWDXkdYN91
	15bPSJixzbrvzCZwrFmPqu3VAZwKU7IHsRf9BLaDiVlB8S8T3Qe+ayDKgXDO
X-Gm-Gg: ASbGnctm+oS2IZxBvu7OEp361c4MqnBGxLuiZOAfz0Ieirb/u39v17XCUyDFcVuaXqF
	N7l4rLCbo53Wf3K2cRyDBOCZOgr3+nZqDP8Jxkq/YdNDmVxDJUVEI+uik+94MfC4SLt63DEw63P
	WVyzgbn44XDYuFdM1tw/0DnHo3y24yQhKsjIPLEvQ5Fj8wDki6ePcLFRBedrvcvRY82QMYwBIxA
	e/eFCKAefJAmcTVeATOK+wKiXB1xc+M1ZvzzaUScB5CqL8PVjYjRsgh7hCNqeB1llBMyMSOxRA7
	0E1sPnplsIkquV6daip8doQd/feP4hC3W7AOmOWkPyVBoJF+OM1i9oqX08A5Rg==
X-Google-Smtp-Source: AGHT+IFgHjSNeoBNptiiEbwluBRQ3IXW3sqx+kBS5+5e/IvlWs4t7RMLzUKV4L4Hb4cfDBGmOWGE+Q==
X-Received: by 2002:a05:6102:162b:b0:4bb:ba51:7d64 with SMTP id ada2fe7eead31-4bc037433efmr4855118137.17.1739511112688;
        Thu, 13 Feb 2025 21:31:52 -0800 (PST)
Received: from droid-r8s ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc07961654sm406029137.19.2025.02.13.21.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 21:31:52 -0800 (PST)
Date: Fri, 14 Feb 2025 05:31:43 +0000
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: alim.akhtar@samsung.com, andi.shyti@kernel.org, broonie@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 0/3] spi: s3c64xx: add support exynos990-spi to new
 port config data
Message-ID: <Z67VP6zMwFcqFurH@droid-r8s>
References: <20250214043343.263-1-wachiturroxd150@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214043343.263-1-wachiturroxd150@gmail.com>

On Fri, Feb 14, 2025 at 04:33:40AM +0000, Denzeel Oliva wrote:
> Changes in v3:
> - Reordered fifo_depth handling in s3c64xx_spi_probe() so that the DT
>   property takes precedence over the default value in port_config.
>   This allows node-specific FIFO depths to be applied correctly while
>   preserving a fallback.

Showing evidence:
[    0.339111] s3c64xx-spi 10920000.spi: spi bus clock parent not specified, using clock at index 0 as parent
[    0.339119] s3c64xx-spi 10920000.spi: number of chip select lines not specified, assuming 1 chip select line
[    0.339467] s3c64xx-spi 10920000.spi: registered host spi0
[    0.339589] s3c64xx-spi 10920000.spi: Samsung SoC SPI Driver loaded for Bus SPI-0 with 1 Targets attached
[    0.339597] s3c64xx-spi 10920000.spi:        IOmem=[[mem 0x10920000-0x1092002f]]     FIFO 256bytes
-------------------------------------------------------------------------------------------------------------
[    0.587452] s3c64xx-spi 10650000.spi: spi bus clock parent not specified, using clock at index 0 as parent
[    0.587462] s3c64xx-spi 10650000.spi: number of chip select lines not specified, assuming 1 chip select line
[    0.587847] s3c64xx-spi 10650000.spi: registered host spi1
[    0.587986] s3c64xx-spi 10650000.spi: Samsung SoC SPI Driver loaded for Bus SPI-1 with 1 Targets attached
[    0.587997] s3c64xx-spi 10650000.spi:        IOmem=[[mem 0x10650000-0x1065002f]]     FIFO 64bytes

