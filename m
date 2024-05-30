Return-Path: <linux-spi+bounces-3144-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5BE8D4E97
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 17:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184251C23BE8
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2024 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68516F0DA;
	Thu, 30 May 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXfQFfHV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B613212E;
	Thu, 30 May 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081335; cv=none; b=XCuwW0NI683nDt7KhVd9JNgBITYr5M7jhfSLy8+BWG4wX+WKLF74tTaqLiaTzIWN9Hzd6IQDm//4gvDoABeKUbxfvpoIodKhKJpD0/3V16QIXdFMVSPOYZdpTxXSDHlLXGrlsZzQheLg5chCqK9DlGVAM0GrwIBoMsiYJvd+uD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081335; c=relaxed/simple;
	bh=Gh9cbHiV0vQlIQ0Ybp3Zq7HDBJmoleGPJjiVwVpWMcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+Bbu3E3EoZ2VbXv/+pdUZ/CJt/LGTt/Orvs5+MlzIrPm1fzfLy4ih9JNSMyW01mCnm82a/oV1cQlqq0oc10G0PV0ETe04dxifGIX4lbFK8dKz+yHSYIOefUCgqUessFjFvJs3QDiBxh6h74RsKCCEoxnt2tblxABOJYI5eCn6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXfQFfHV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4201986d60aso10184715e9.3;
        Thu, 30 May 2024 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717081332; x=1717686132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=giZRcSqmVr6pTJj0L38lY8BgbAhYw8xa4kQEZAhZtZw=;
        b=dXfQFfHV8rNNADGRQawC68BCZOHHSxknXds9ZOJEtExlFac9qXLfoyUN3h+3H9Tnbe
         CKYoy7IpE229cV3lNS3NxLqLVecZVSikBGstLdvR1vUJIErYncGr4xPDOxkble+LuHy/
         22ORlMqOwHaZagfZM1DyBysK6yUSxZcf2NZxoS6IPw5Xd2XbAE7LWmXho8JADi6wB77O
         DFNu4Rgq3CA33KFyfzebRW5xX5Luioj5QdG+dfMfm32rt0lVWqVb9jacituDKbPXthJX
         n3pFMDLF0akvyZtK4G03xbWkrM/RLgEeRmqTTit3CknBYt08HRD3OXOGmc3U99jTtIH2
         zlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717081332; x=1717686132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giZRcSqmVr6pTJj0L38lY8BgbAhYw8xa4kQEZAhZtZw=;
        b=V/35V5Y8RaFMAWD2xSDK8VnOCx7+QGugtTKG6ouh9WQZnSBrLyzydvMwC+2ELOI3Dh
         TSXLuCW8WMoV+lvQ4HdIC6m4ikwP+5TomO3s2as4zZNPVJFwptfJxoPiecjulOFZzVds
         UQOZI9/f67IGGuZdi54+3gFIxPftrm9w1LO2Ls6xKc/ULuAdEdmNJ+MsJ/TfBoAM4TU9
         nXpJtUyHETBRBHcWYWZT7lJLiRDi8H58n5LWAY5HLiDdTw4c2gPjIlPv/m4RxMf95itA
         1AMeCDuUryh/OFpgy232RaAQp1KhHScELKcbhBRplu2zwKOcos09KSKtCYlgjfKUUJbq
         Blcw==
X-Forwarded-Encrypted: i=1; AJvYcCWt4rsfgMpezIibizUXm40jgGEHppljPvIAqmttO7bMKQP61fOBRaWsAM0cZoIxlKS2vTycILnRseSbEryK983AOGwHSOZDvLQH9hPEWS1VSD12q3emGmqVbyMbNoyhe0YxC90QJ/4KusAuaPu/UXWgpfmoOoAkk/2eMDZlmkCYtV0Wyg==
X-Gm-Message-State: AOJu0Yygx36pcZP5bCIxJiPjeIre93YfBUI0IRMSqzWyZQe0pe+3SFu2
	AichiijXMAKUDclhDd52sxTmc7XDDGAcfVPdgH9unccWyhHEYYcOQ9zMsTR4
X-Google-Smtp-Source: AGHT+IFjQF/lcM7ZPr6DlNqP24gQj5UIxSjOg0Yx8aoFMh9AlWjbAddylnUOhdKXlfOwpdRpBPxpGA==
X-Received: by 2002:a05:600c:4ba4:b0:421:15f:186a with SMTP id 5b1f17b1804b1-42127932790mr20985215e9.39.1717081331646;
        Thu, 30 May 2024 08:02:11 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270662bfsm27600385e9.15.2024.05.30.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:02:10 -0700 (PDT)
Date: Thu, 30 May 2024 18:02:08 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] spi: dt-bindings: fsl-dspi: Convert to yaml format
Message-ID: <20240530150208.k3xdobbxznaqchch@skbuf>
References: <20240529193651.1029840-1-Frank.Li@nxp.com>
 <20240529193651.1029840-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529193651.1029840-1-Frank.Li@nxp.com>
 <20240529193651.1029840-1-Frank.Li@nxp.com>

Hi Frank,

On Wed, May 29, 2024 at 03:36:50PM -0400, Frank Li wrote:
> Convert dt-binding spi-fsl-dspi.txt to yaml format.
> 
> Addtional changes during convert:
> - compatible string "fsl,ls1028a-dspi" can be followed by
> fsl,ls1021a-v1.0-dspi
> - Change "dspi0@4002c000" to "spi@4002c000" in example
> - Reorder properties in example
> - Use GIC include in example
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     pass dt_binding_check
>     
>     make dt_binding_check DT_SCHEMA_FILES=fsl,dspi.yaml
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       CHKDT   Documentation/devicetree/bindings
>       LINT    Documentation/devicetree/bindings
>       DTEX    Documentation/devicetree/bindings/spi/fsl,dspi.example.dts
>       DTC_CHK Documentation/devicetree/bindings/spi/fsl,dspi.example.dtb
> 
>  .../devicetree/bindings/spi/fsl,dspi.yaml     | 126 ++++++++++++++++++
>  .../devicetree/bindings/spi/spi-fsl-dspi.txt  |  65 ---------
>  2 files changed, 126 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/fsl,dspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
> new file mode 100644
> index 0000000000000..12a67b2cc25c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Freescale DSPI controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  fsl,spi-cs-sck-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      a delay in nanoseconds between activating chip
> +      select and the start of clock signal, at the start of a transfer.
> +  fsl,spi-sck-cs-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      a delay in nanoseconds between stopping the clock
> +      signal and deactivating chip select, at the end of a transfer.

Thanks for this patch and for picking up on this task.

But fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay are not controller
properties as this schema makes them appear, but rather, child node
properties.

Could you try and take a look at how the previous attempt went, and
incorporate some of its good parts?
https://lore.kernel.org/linux-spi/20221111224651.577729-1-vladimir.oltean@nxp.com/

