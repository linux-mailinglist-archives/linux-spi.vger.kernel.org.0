Return-Path: <linux-spi+bounces-6838-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48FA3767F
	for <lists+linux-spi@lfdr.de>; Sun, 16 Feb 2025 19:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C761892AB3
	for <lists+linux-spi@lfdr.de>; Sun, 16 Feb 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D6519E99E;
	Sun, 16 Feb 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="fRSHGNjN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179F19D890
	for <linux-spi@vger.kernel.org>; Sun, 16 Feb 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739729556; cv=none; b=RZOAK/jMzBil+UN1MgHCcIjBCKezqOzTFh4Nt8D2mylolv9QDSszeNc3yReqbN0flcP0RaDGM+EmbqBk6YnuvzlTNq5RNaOAZdX+lkm/K8YUC3cL6gUuOUnKgaEUPgGsnbKSE9TI+uKgJY9iJLprePWDTZ0xyCFQVZzr6bZHXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739729556; c=relaxed/simple;
	bh=YUqph/b4fBwdoaZ+voCpRWWS6XtVpDBsEp5ssxllxE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKl9y0H7SCwSWAYRXvL/B4fVgfHAzRFtmysLCtkF7UgPFesDJX/ytgXpAlb1vbNqiJFnfiyTUj1CmuAkFbNrWyxET5ZOA0fHb8ppfIu9VH93MihUr1fjuxOuuTEo3kFpXeQfUFyGSPv4iI7Q46+jGrAhb86njmcV3FSUTExQNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=fRSHGNjN; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 360A7240027
	for <linux-spi@vger.kernel.org>; Sun, 16 Feb 2025 19:12:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739729552; bh=YUqph/b4fBwdoaZ+voCpRWWS6XtVpDBsEp5ssxllxE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=fRSHGNjNl1cAmfChbInU63IRKQoTu0JS4Iplfwe6RMf1WKD/8cj1/It/DYf7mq3SO
	 YYOBmVZjU/UUQJtErfw/Vv/SWTzbu0/FmZcn4PFWEYFufoigcMrJ61CTy3Gy4uYAVr
	 4uv3Ys+FTeiG5ex24zqk1VNfKtgXa/Ga0Qt74Mcc4toniz1OCmFfwdFl7CoZHKfDJ3
	 C3HrXTooDAaMfAUdpm7iRMmLtB2EVfetl428iA4VwI1k2D77rjkmG+2NR0fcpU+07m
	 N2K7T2bnW27tZzoW2bN0x+LJuOe6avDzrxNt7l22CJifL2g9IzlI/a2ptu6b9mjJGi
	 0xKN+sirq5c2A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ywv5R2d3Hz9rxK;
	Sun, 16 Feb 2025 19:12:27 +0100 (CET)
Date: Sun, 16 Feb 2025 18:12:26 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= via B4 Relay <devnull+j.ne.posteo.net@kernel.org>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, j.ne@posteo.net,
	imx@lists.linux.dev, Scott Wood <oss@buserror.net>,
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
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 12/12] dt-bindings: mtd: raw-nand-chip: Relax node
 name pattern
Message-ID: <Z7Iqir-qaZDt6tsx@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-12-8137b0c42526@posteo.net>
 <87o6zaurv9.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6zaurv9.fsf@bootlin.com>

On Mon, Feb 10, 2025 at 09:27:22AM +0100, Miquel Raynal wrote:
> Hello,
> 
> On 07/02/2025 at 22:30:29 +01, J. Neuschäfer via B4 Relay <devnull+j.ne.posteo.net@kernel.org> wrote:
> 
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> >
> > In some scenarios, such as under the Freescale eLBC bus, there are raw
> > NAND chips with a unit address that has a comma in it (cs,offset).
> > Relax the $nodename pattern in raw-nand-chip.yaml to allow such unit
> > addresses.
> 
> This is super specific to this controller, I'd rather avoid that in the
> main (shared) files. I believe you can force another node name in the
> controller's binding instead?

It's a bit tricky. AFAICS, when I declare a node name pattern in my
specific binding in addition to the generic binding, the result is that
both of them apply, so I can't relax stricter requirements:

# raw-nand-chip.yaml
properties:
  $nodename:
    pattern: "^nand@[a-f0-9]$"

# fsl,elbc-fcm-nand.yaml
properties:
  $nodename:
    pattern: "^nand@[a-f0-9](,[0-9a-f]*)?$"

# dtc
/.../fsl,elbc-fcm-nand.example.dtb:
nand@1,0: $nodename:0: 'nand@1,0' does not match '^nand@[a-f0-9]$'
        from schema $id:
	http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#

(I changed the second pattern to nand-fail@... and dtc warned about it
 mismatching too.)

Perhaps I'm missing a DT-schema trick to override a value/pattern.

Alternatively (pending discussion on patch 11/12), I might end up not
referencing raw-nand-chip.yaml.


Best regards,
J. Neuschäfer

