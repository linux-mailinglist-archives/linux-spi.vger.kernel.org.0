Return-Path: <linux-spi+bounces-8835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5397AEC0F0
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 22:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E0B7A1F49
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6E220698;
	Fri, 27 Jun 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5yqlZCz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7DC2FB;
	Fri, 27 Jun 2025 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056115; cv=none; b=BFw0uy0GelsMyKcxmglk4WyGKkzF62O7gC9pU+eAE7kKlX50i1qxWa67uDX1uj+l/C67k7RbLMua+Doq3OOUNdkSUve0sBst0GUzk7jdcPrfLSKITYd7oS0QknCBK2xsoOj9GPjYIe0vqoPmVk4eTV8Yp0qKXVn3kCNccmS3UEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056115; c=relaxed/simple;
	bh=l5bThpeYgD4nwLUsGFwxtgtbBvr/hpMTIowA58WLrsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNJaQR9jSwppfvr+3TqVd95Fiay2rMlBXshzFypVI0h/akOpfbIoFwWovg1iYD9yW4Cij5DLcXCLKoH7MwSIbXv/M+VapeIpAK1OKgD8ddpG4jt1ohN6zd+eHsdVZ2RQqpYNg9arXFUjurYP4v2Q1Nct/LQS+uEjkRHekdR1XUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5yqlZCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADAEC4CEE3;
	Fri, 27 Jun 2025 20:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751056114;
	bh=l5bThpeYgD4nwLUsGFwxtgtbBvr/hpMTIowA58WLrsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5yqlZCzC+s9BYC0oBPqjqjF9B5PII9nJmRMoxO7g+8Jb3eKovxDYc/ezeL2hutE/
	 V9jpKQnCsByJTXd79boeLzq9eLIm8PSuy3ppQUiys+bCw/v1BRt+2SmRZ+vE2fWej2
	 fmLtfhMmVZikXVUQ6xER+7hT2dteoPVHJlDNuy0I0eVwtbc49mvhJkl6aPzeSNTxgj
	 YMZXXeO2LxSNBFoQnvxEFVj3LNlTuCQGYmL+NJLlSoHIg2XohETTC/h8BBpUGX/bq4
	 HQPjeX1ZBQ6M1jHw+oryFTqVti5ddJVj3ajNWpFOUdIWXHT76KdX7RaCPKvbzg03xB
	 fpE1EYfJ7pLcA==
Date: Fri, 27 Jun 2025 15:28:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-spi@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 2/6] spi: dt-bindings: Document the RZ/V2H(P) RSPI
Message-ID: <175105611355.30065.8146598698552154225.robh@kernel.org>
References: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
 <20250624192304.338979-3-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624192304.338979-3-fabrizio.castro.jz@renesas.com>


On Tue, 24 Jun 2025 20:23:00 +0100, Fabrizio Castro wrote:
> Add dt-bindings for the RSPI IP found inside the Renesas RZ/V2H(P)
> SoC.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  .../bindings/spi/renesas,rzv2h-rspi.yaml      | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


