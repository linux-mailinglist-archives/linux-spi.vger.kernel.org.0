Return-Path: <linux-spi+bounces-3634-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5491AD0A
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 18:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF0EB245AD
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A221990C5;
	Thu, 27 Jun 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SeYKmVWZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E921494A1;
	Thu, 27 Jun 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506561; cv=none; b=kb39prL+wnl7BpWaLFpXIFbDYcrn4E4tWnuFgFwh7hymsEPVaqvV3C01uQhGoxGPBmh1xoDQ7tGB6fH1ppElOex2QCckBjyg1cws9nM1b+aLrdk6Iu6h7L6lL8xmHWmQV3mvf9wcy4uW5fP6yvLg8XxzczFH6SZRQ3rqkiFXspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506561; c=relaxed/simple;
	bh=3oH4rqYKfd0K+WONRYcAnuUAoWbfKb8KPqDdjkxEPCM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trMgfCyaWLGZvGJ+qZhfL8EtFczMH/N9Rn5vJ3zeMdZcF83ylrJSs+KAcwl1hPdLTY2E+rpceeydtF9PQF9j+LE1fOA2FxvCgLAAi+C7bLlQQROzH5ERbRi0PZXsDEqTVP/o/2Df2iwNlMST5BgI7lx+UD35MR7X1ODqitgks1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SeYKmVWZ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RGgL5J036299;
	Thu, 27 Jun 2024 11:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719506541;
	bh=JjK4z9ZpwyGeBOi7X80aP2waEJDLXA1nIRzMg8HKCVs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=SeYKmVWZ1o5UwKPhH19tvtNkpOZ6jvWe389EcFJ9AdKq0XceYHNFc5G0Lw1azNH7b
	 yEFdmN3cXRkQp2a10Sy1S3s2FcCqxNuQyS4wcmVZmNkwU3dxFmkV06LIjWaH/CH+q8
	 eAGXuQxurw6qnVrs1L1ItuCBCJavPQVVzdrr9ruY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RGgLo8102258
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 11:42:21 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 11:42:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 11:42:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RGgLKx026188;
	Thu, 27 Jun 2024 11:42:21 -0500
Date: Thu, 27 Jun 2024 11:42:21 -0500
From: Nishanth Menon <nm@ti.com>
To: Ayush Singh <ayush@beagleboard.org>
CC: Mark Brown <broonie@kernel.org>, Vaishnav M A <vaishnav@beagleboard.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Michael Walle
	<mwalle@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, <jkridner@beagleboard.org>,
        <robertcnelson@beagleboard.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 7/7] dts: ti: k3-am625-beagleplay: Add mikroBUS
Message-ID: <20240627164221.st5ugtn2n7bctj7g@justify>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-7-9e6c148bf5f0@beagleboard.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 21:56-20240627, Ayush Singh wrote:
> DONOTMERGE
^^ might be better off in the diffstat and explain why DONOT MERGE :)
[...]

> +	mikrobus_spi_pins_gpio: mikrobus-spi-gpio-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0194, PIN_INPUT, 7) /* (B19) MCASP0_AXR3.GPIO1_7 */
> +			AM62X_IOPAD(0x0198, PIN_INPUT, 7) /* (A19) MCASP0_AXR2.GPIO1_8 */
> +			AM62X_IOPAD(0x01ac, PIN_INPUT, 7) /* (E19) MCASP0_AFSR.GPIO1_13 */
> +			AM62X_IOPAD(0x01b0, PIN_INPUT, 7) /* (A20) MCASP0_ACLKR.GPIO1_14 */
> +		>;
> +	};

we could potentially get rid of these if we get the gpio-ranges correct
on pinctrl? I have not gotten around to am62x yet - but see this:

https://lore.kernel.org/linux-arm-kernel/20240627162539.691223-1-nm@ti.com/T/#t

[...]
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

