Return-Path: <linux-spi+bounces-11879-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54089CB8884
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 10:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 511A3306CA0F
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F152F8BC8;
	Fri, 12 Dec 2025 09:49:40 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724C2874E3;
	Fri, 12 Dec 2025 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532980; cv=none; b=JEj+w4+gWWulDU+wPC9hVNFBGpXJpcDZ1b89mimg5bF48L+Koc0+licJczhE5GxjM1Bk5jcX2wYMDYOLlNPhYSO190czEtU41EFNcpJJ4IPg1vFYexSF1gOQDBMx0phy/+vE/1JEoOEI0o94S//uxIvknoIwXGh8og/u8BMdyAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532980; c=relaxed/simple;
	bh=K25Ijgc/BM3blmvklpXrCkKN0IcPd1eYBRFuDZGcUxE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrhlMujDo7WimKZtWuZsJtX7xuk8WnfTzC0XSagLKYCpcFRdDXl/9+4KCG9jPzEF4GkclS0uZpcrFamT6pklxGg98PCSrepNTiI9OB2LXd55pDcfF4YdxyVUtnxWAg11B++rpOlxp+B5Z9ElYvdinhgw2r1aujCntOOzQRfZDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 5BC9nN5G091007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Fri, 12 Dec 2025 17:49:23 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Dec
 2025 17:49:22 +0800
Date: Fri, 12 Dec 2025 17:49:22 +0800
From: CL Wang <cl634@andestech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <broonie@kernel.org>, <linux-spi@vger.kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: spi: Add support for ATCSPI200 SPI
 controller
Message-ID: <aTvlIqS3KnZZ1UlU@swlinux02>
References: <20251210090430.3602380-1-cl634@andestech.com>
 <20251210090430.3602380-2-cl634@andestech.com>
 <33e24f43-53d3-46cf-9012-aed67230723b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33e24f43-53d3-46cf-9012-aed67230723b@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 5BC9nN5G091007

Hi Krzysztof,

Thank you for pointing out the mistake. I’ll make sure to properly verify the
change log formatting before the next submission. I appreciate your guidance
and will follow this practice going forward.

Best regards,
CL Wang


On Thu, Dec 11, 2025 at 06:31:23AM +0100, Krzysztof Kozlowski wrote:
> >
> 
> That's a completely corrupted changelog.
> 
> Please apply your patch and look. Or run checkpatch. Does it look good?
> 
> Best regards,
> Krzysztof

