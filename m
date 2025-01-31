Return-Path: <linux-spi+bounces-6595-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E870CA23D40
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jan 2025 12:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346DB3A9BD5
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jan 2025 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2610E0;
	Fri, 31 Jan 2025 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Yz9CI78/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C31C1AC7
	for <linux-spi@vger.kernel.org>; Fri, 31 Jan 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738323593; cv=none; b=u2mVvdVX3mSUKdMdBMSLe3sEOp486NnWkcPwtpTctRUuuACkcahxzh80jZ0eeD3r8XVChaTPzOnoQ9xf6PJV+qEh+Ytwz2OIvT0RCyneqhJXAYtxmzVrywqeRBlAr7JHu5HVd1FCpYPbXqcbf1b41UBK2FHwP9PU5D8OCd3t218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738323593; c=relaxed/simple;
	bh=476EBTGgcI5xdYOaJ6LQa3tfmwSruyF9mYzvA+HovWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giPyo5j8bMbSdBOcrshKZ9BxPqGJpRwEa12rzcKL4YbXVs3+f5p/n+RKPPo2Rq7v4taK4tJ54x+S1ZkM9dXgsWq42YkYGp8GZQYRyULQa6++cYmgdpdOYzT0sxo2G4StchkaQH5X2vt6dO9O08Z9zB/WL3LRESoscifnqnhV7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Yz9CI78/; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1E85C240104
	for <linux-spi@vger.kernel.org>; Fri, 31 Jan 2025 12:33:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738323226; bh=476EBTGgcI5xdYOaJ6LQa3tfmwSruyF9mYzvA+HovWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=Yz9CI78/fovWb2L5arMhqzICRpUn5PDCJglnqxot979BF/cz24B57yuu4aqG+WEsA
	 SwkGWcjgcrBU0WNZOH5ITMaS93rkXZ5MKtflImxIJt3OEmQhmszJJZmMatbXyhZ4bj
	 9eN6uGxkTzbO3lC3ZbMVIteudpPKS6+AdjcAQogx5QcbvxPI4VmDx8o1g4HJVTxM3n
	 wFVcW3I0tdDAt9EwDVnVPV8xr9ykgPT5lxzvCP/k4JSgJgzI22+ncddHWp5ZTvMMz0
	 Xps9MsPE2HzxePqW35oCBQWUWRgqSQV/OvOk7usYRAPfrme2gy7aX9OnJUFBT91Osg
	 whcxqOR2a8c7w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ykv0g42F0z9rxF;
	Fri, 31 Jan 2025 12:33:39 +0100 (CET)
Date: Fri, 31 Jan 2025 11:33:39 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Frank Li <Frank.li@nxp.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 0/9] YAML conversion of several Freescale/PowerPC DT
 bindings
Message-ID: <Z5y1E6TUclqzV2Rp@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <Z5qr1VkKSlyBE/E4@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5qr1VkKSlyBE/E4@lizhi-Precision-Tower-5810>

On Wed, Jan 29, 2025 at 05:29:41PM -0500, Frank Li wrote:
> On Sun, Jan 26, 2025 at 07:58:55PM +0100, J. Neuschäfer wrote:
> > This is a spin-off of the series titled
> > "powerpc: MPC83xx cleanup and LANCOM NWAPP2 board".
> >
> > During the development of that series, it became clear that many
> > devicetree bindings for Freescale MPC8xxx platforms are still in the old
> > plain-text format, or don't exist at all, and in any case don't mention
> > all valid compatible strings.
> >
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> 
> Please cc imx@lists.linux.dev next time
> 
> Frank

Will do.

Best regards,
J. Neuschäfer

