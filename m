Return-Path: <linux-spi+bounces-6626-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B5BA27FAB
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 00:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AA23A3DBF
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2025 23:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA9121E0AC;
	Tue,  4 Feb 2025 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="DBuTUrKv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F020468C
	for <linux-spi@vger.kernel.org>; Tue,  4 Feb 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738712075; cv=none; b=Rb+3vrRspRFBIMfBLrNne2r0jahW/dvVHsDYr5FQsndK4y7iyNoch4FrG0lcH43QdxygUujVF8l418ah03ANxSg4J4VMoIu1oDXaKImHrYOwfBmo4te3/SMp5z/BaQvQUfipl5uhMK9YbiQFK51bfn6fH8Vqd2SyCppQ9g7mlIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738712075; c=relaxed/simple;
	bh=ZyVExCqzB2iyA3bGQRpDduhuvKS4WRQAEUDFtlqCUyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQOB5Vr4CVknYwsEOBv6DLt/3r61SjJbBTxErSTj54aGlPw6eiMwcUzu5ezhouOtwyZaDhZ2G1UPKq09YktcLtf5+4dqzqzluxNSCIt48P8xYGLgahxGMzumP41PpKM/hmslGv2c/unoE8i+QDjCVmep6NXjbtc6sw2F355f2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=DBuTUrKv; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 58ACD240101
	for <linux-spi@vger.kernel.org>; Wed,  5 Feb 2025 00:34:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738712071; bh=ZyVExCqzB2iyA3bGQRpDduhuvKS4WRQAEUDFtlqCUyc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=DBuTUrKvwBPCFb3wwTF27nUmKACldPAcQK56BYzilnfVJPf906YaloXYiMrBH0c8c
	 vIuQx+YGYTxutPEplefcxq8yPY37zyFAgpbLU6vWf/V/09gaXv9jpMdG1O9VTiAqZf
	 y3RU6mPPwJm03hw0li/MOC9HLNHPTIthKkPNCuvplIYQqPzLkejWIoUDMNA6fb0GEz
	 MXx7QT9XTpACA6ETCFVSYuQe4WroRMb+BIlsBRIPjO+EN0pliE531twvejZqcI+Nlt
	 GgJWtXw4wqJWoCOpmvC72HFB+3ku/yRvl2HD/J/3mKxYeJYNYBMkjmgGhoKwtjXWMV
	 Fi8SRj0C0Cjow==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YnfpX3DL2z6tyt;
	Wed,  5 Feb 2025 00:34:28 +0100 (CET)
Date: Tue,  4 Feb 2025 23:34:28 +0000
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
Subject: Re: [PATCH 6/9] dt-bindings: pci: Add fsl,mpc83xx-pcie bindings
Message-ID: <Z6KkBEaGTkSyWiE_@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-6-50649f51c3dd@posteo.net>
 <Z5qx3jAFE81Ni2cJ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5qx3jAFE81Ni2cJ@lizhi-Precision-Tower-5810>

On Wed, Jan 29, 2025 at 05:55:26PM -0500, Frank Li wrote:
> On Sun, Jan 26, 2025 at 07:59:01PM +0100, J. Neuschäfer wrote:
> > Supplement Documentation/devicetree/bindings/pci/fsl,pci.txt with a more
> > formal binding in YAML format.
> >
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> >  .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 83 ++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
[...]
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    pci1: pcie@e0009000 {
> 
> needn't label here

Will change.


Thanks,
J. Neuschäfer

