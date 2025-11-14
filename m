Return-Path: <linux-spi+bounces-11192-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BDC5C63A
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 10:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FF80359ED0
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70F308F16;
	Fri, 14 Nov 2025 09:46:32 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946D3081D3;
	Fri, 14 Nov 2025 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113592; cv=none; b=K4p1nnH5KqOiYGbuJSkEfkM9mHEnCF26Ho6YMNUHuoUUjErMUdw48v42sJTDJCKdv0x4sfhb6Mxv/jpwueWMR4m9Y/8WkROVkWrsMbZOXZUZK2fUIsCVOcx2dICJPqKFOY8jJf2XgXEOPRMeG73tvsagmev/i9jGK8mkA8hfvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113592; c=relaxed/simple;
	bh=jkwEalFk1ykaBVfLvuMDkX2l/SWvGRFKLBGSJDYhBuk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8g2yXw8FiaRkgjfbMbInT1n66gPONv+C1+hznhujnbbLMnE5tRQemqhKenEorIp/ke+pctVC7PgfAe7g3WuBrAsMPUlQ5s3qr2LGFFXLfpBYfaMTbhLpWpcdOmMtvMexI3eCbblItS5Bq/Yt+Hj6dfpadazrkOM6rP5MuglLUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 5AE9k0jS029023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 17:46:00 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Fri, 14 Nov 2025 17:46:00 +0800
Date: Fri, 14 Nov 2025 17:46:00 +0800
From: CL Wang <cl634@andestech.com>
To: Conor Dooley <conor@kernel.org>
CC: <broonie@kernel.org>, <linux-spi@vger.kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add support for ATCSPI200 SPI
 controller
Message-ID: <aRb6WDSAbfre28eT@swlinux02>
References: <20251112034724.1977630-1-cl634@andestech.com>
 <20251112034724.1977630-2-cl634@andestech.com>
 <20251112-reoccur-quill-2144810ce062@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112-reoccur-quill-2144810ce062@spud>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 5AE9k0jS029023

Hi Conor,

Thanks for your suggestions. Please see my responses below.

> > +title: Andes ATCSPI200 SPI controller
> 
> Is this a spi controller or a qspi controller?
This controller is a standard SPI controller that supports single/dual/quad
modes.

> > +  dma-names:
> > +    items:
> > +      - const: spi_tx
> > +      - const: spi_rx
> 
> Drop the "spi_", since it's obvious that it belongs to this controller.
As you suggested, the spi_ prefix will be removed, since it is clear that
these channels belong to this controller. In the next version, the DMA
channel names will follow common conventions used by other SPI controllers:
dma-names = "tx", "rx";

> > +ANDES ATCSPI200 SPI DRIVER
> > +M:	CL Wang <cl634@andestech.com>
> > +S:	Supported
> > +F:	Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
> 
> > +F:	drivers/spi/spi-atcspi200.c
The MAINTAINERS entry will be updated in the next revision so that only the
Devicetree binding file is listed. The driver entry will be added once the
driver patch is introduced.

Thanks again for your review and suggestions.

Best regards,
CL


