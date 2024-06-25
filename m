Return-Path: <linux-spi+bounces-3577-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82AB9167EA
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9219F288505
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 12:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61F154457;
	Tue, 25 Jun 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEN+gIzJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8914A619;
	Tue, 25 Jun 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318822; cv=none; b=PcaqJdTRCwi7VW+Rd2HFcfIPFyH3FLkAEcGmsCrjyiCxy/Bp07aeTZr/lqCkv0LK7ea1Z2XFwad/YsjUNU+/AETT1/bmfbRzFUmroMrnAkPRZIVheLxxN9m4VUgQz5G5TWc2iffWm32IcT92UAHI9iUeLiodU/DKerVDQXD4PNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318822; c=relaxed/simple;
	bh=ouDgNAhiOJABtZd0VRBjqm8wBra3HObZGuom3w81Y08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJnPyS4p5t/OH3RMwZyqluvRiuNCEnDiqt9A+nLlW/eHIp53+JuQfXjaEiDFG7ZgRDz/f6gV42YmEviy0cJ9alFpnOsmHOuzcIx4BAvecwa8G9UPnL/fJeF4NF81Pw/jZwNWAYlDvI9NwnSP7J1Oz9SzFG+q2KG5+T8eppHvNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEN+gIzJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4217926991fso47537515e9.3;
        Tue, 25 Jun 2024 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318819; x=1719923619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/11/hyoYBdDR9OuAjcDpX5M0LFu3VP2tezkbOpybB0=;
        b=KEN+gIzJNA9A6P28+xIsN1GxzYwCYrAJAsauejOpEED3Cns2JzoJXVzBNtWELb5b8B
         ku2V12fltV77OQlnRikNlutvVP+1tEMYNM1QPAuOmXyUbxVOAHJPFNeo2Cb7+iA9BIPH
         PQm/VBNaxQsVJq6TuYVMnhBKUg7o3t3oSNmnWH86RQPinh+LiD8i4Atz04qOhpax4rfK
         NQWsxNbw0WoEaN9emt5wMI0LEEU8kYb9TlON2+Acs2aQmjUZKNoAqJOd9LDmBCgkuTPe
         o6AEJ6NBQml+Ip0oyllXjH9Vc672R/jyNAuA8WozxIfM6a/MM1WryUKr15SvPtRCfFZS
         oIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318819; x=1719923619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/11/hyoYBdDR9OuAjcDpX5M0LFu3VP2tezkbOpybB0=;
        b=MuDjlWO+wKf71hYHkFlcK8vCX3Qm4L1GMidIM526mmSTMZCVb7BZIYtoCAdBtMdzxq
         dzdixy2uFhN6qUbBQeP36Bm2TMZV8RbFdjrn7i42/xzTsyiQbLiThCgujVsB5E7URyQX
         a9tlD2fgX2IpQDk5eKg7zkYINgAEOAIPvNc86e9CDnIKdWecCfET1CSCWHYd9lKOpoVD
         /OFnF6jsSxgjfpM1dXNXwVweS1+VHWMYKugqhE1SHQhzRxb6tsZRJYceQblHSaril3B/
         rT2aDL2OzocXj95mzfoZZqIXi1ClTdCH6yc5GVNNVrDc5O21yBMK6DL5KGv3xoFOz6Pr
         NxcA==
X-Forwarded-Encrypted: i=1; AJvYcCUNMOgyY30NkEiq5JTXF8ZwoNpmF3gZU31c6aM79bdB7bw90mJXZuzwS3QEb07msV0AKtM0TgiewoDXUieubIyhaNCbtCJAuyRKJwBGJ3MVEoEpc8rjgoy002vRiblPlJonaAwBNNY3KEqNhugMV0I2YmWJH+iXAi4EqvNh0q8UVbDk/A==
X-Gm-Message-State: AOJu0Yy1LYfaNwAclm6ObAIkzWZO8Pd6wzc49vMLGU00ICVeZyW7rVH/
	2+x07BlzNA/nDeKQaGiHiu2PThJe5yb6wBIjEqvIO0M6AMTfTStL
X-Google-Smtp-Source: AGHT+IHhnOnIodnFCxeYBhMXVK0if3VnPi/+2mhZS3e9FrCXnLgJcv5hamzattUDgvVdgPK7NBoyEw==
X-Received: by 2002:a05:600c:6dd3:b0:421:ad42:c4c2 with SMTP id 5b1f17b1804b1-4248b9575famr56722695e9.10.1719318819162;
        Tue, 25 Jun 2024 05:33:39 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d21243esm213969425e9.43.2024.06.25.05.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:33:38 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:33:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Kuldeep Singh <kuldeep.singh@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v4 2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
Message-ID: <20240625123336.7ofgzasbwczdaask@skbuf>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-2-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-2-3d1c6f5005bf@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-ls_qspi-v4-2-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-2-3d1c6f5005bf@nxp.com>

On Mon, Jun 24, 2024 at 02:55:28PM -0400, Frank Li wrote:
> Convert dt-binding spi-fsl-dspi.txt to yaml format.
> Use part Vladimir Oltean's work at of
> https://lore.kernel.org/linux-spi/20221111224651.577729-1-vladimir.oltean@nxp.com/
> 
> Additional changes during convert:
> - compatible string "fsl,ls1028a-dspi" can be followed by
> fsl,ls1021a-v1.0-dspi.
> - Change "dspi0@4002c000" to "spi@4002c000" in example.
> - Reorder properties in example.
> - Use GIC include in example.
> - Deprecated fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay by use common SPI
> property.
> - Use compatible string 'jedec,spi-nor' in example.
> - Split peripheral part to fsl,dspi-peripheral-props.yaml.
> - Remove 'interrupts' and 'pinctrl' from required list.
> - Update 'bus-num' description.
> - Update 'spi-num-chipselects' description by add "cs-gpios don't count
> against this number".
> - Remove 'big-endian' description.
> 
> Co-developed-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

