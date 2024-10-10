Return-Path: <linux-spi+bounces-5194-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE769998784
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 15:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694C42898C3
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592A1C9B6D;
	Thu, 10 Oct 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xdy6LJKZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7A1C3316;
	Thu, 10 Oct 2024 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566561; cv=none; b=owSjsZjz+ttcTw+dfbrOnfLoYhilP56NHLG7m6welUVnfdn2fsZX3jb2ImylLQMdEmZ3NRaZUuWiatywbPCbPs1JYEt+OAsQrfyQXKmfX/WJkvZ6rzGx6g49nB4WLUlwKLoc21/eyY7L0leWuppvYotZrfchsaXjxOh1fX9ChFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566561; c=relaxed/simple;
	bh=zU4OHd4fqQutU5LKhoOEeIxeaA4fdDxhCxQBuGiHw7Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQz42fOL0Cst9ARD2hX1VtmibL8kaz8mMvdmKMVVfH7Cmx0Tzsq73qMWHf2ceUtMdF9DCqx5Yo+3RH53nrD4BRSNOHij/UNVYP/Wgdnsfl6XQZeHkioXUSozxZQ9CJGnvpedVguXj05vXLTnSYhX88OMCKnWIdQ3wPPTxuv371w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xdy6LJKZ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A8iLrg000495;
	Thu, 10 Oct 2024 15:22:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=Ccn+f/QO1SGOWh5NjiitG2bf
	+psS5zLHBT5PvfxdYR8=; b=xdy6LJKZivFTdUh1VV1XDLky5AuuZTcrXAWwIwsO
	xTDkhIVExC/Q0Tc5IPCvrDtczIXuyTotXmE5JDF6Z3ut433A1hs1hKYWg6B2x6p7
	4iMon06BvLBivZOY0doHSLiNagHWbGlaD7Kh9/LJH9byEg8ll9GONLBWHTsA9SX5
	abVuehsNY/FqSJqmR3tlxicJ7/MYbfL75u/OECm2Jz14ChQtjllpRIcqFfyJmJ5U
	oFgZbhyXaXXAhq9czU7KQTV3g+K81baE6TEZQj2dZ0tjaZ+WR3SxdlyviILpudra
	2GhehTbDClUyxmZyQ+YHZb1bdFzWlI3iq2NYlu1Q0pj6fw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 423f1173q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 15:22:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AD4B54004C;
	Thu, 10 Oct 2024 15:21:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A59E23CB43;
	Thu, 10 Oct 2024 15:19:34 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 10 Oct
 2024 15:19:34 +0200
Date: Thu, 10 Oct 2024 15:19:29 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Mark Brown <broonie@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] spi: stm32: fix missing device mode capability in
 stm32mp25
Message-ID: <20241010131929.GA3275914@gnbcxd0016.gnb.st.com>
References: <20241009-spi-mp25-device-fix-v1-1-8e5ca7db7838@foss.st.com>
 <ZwavaP0QHQCyDbtB@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwavaP0QHQCyDbtB@finisterre.sirena.org.uk>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Mark,

On Wed, Oct 09, 2024 at 05:29:28PM +0100, Mark Brown wrote:
> On Wed, Oct 09, 2024 at 06:15:52PM +0200, Alain Volmat wrote:
> 
> > Fixes: a4e7908abf0c ("spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc")
> > Cc: stable@vger.kernel.org
> 
> That SHA1 doesn't exist...

Oups, sorry about that.  Sending a v2 with correct SHA1.

Regards,
Alain



