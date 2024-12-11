Return-Path: <linux-spi+bounces-6005-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2A19ECE75
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 15:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AD31888D73
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0FF1CD3F;
	Wed, 11 Dec 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpFM8mJz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1A246322;
	Wed, 11 Dec 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926944; cv=none; b=muHf2JxAhSyeHWrHbI5s7SR3PFuAa6IHKYgAt1CnEzGw1bxxGlqB+VtHl7FGWRkfemk/Zx78UJNgcHFXflTbKEwpDAf56bF6Yu4VzxHsJoIlr4JHMQMqoEK0qZx8KgGMH0BiIEl4DpD8w5ZYtWNjNE89G8UPJ1vIJ8c+lv1/kYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926944; c=relaxed/simple;
	bh=haNvrp7vfLxxotz4/f+JScoeb3XX4wNKAxfWcxSqFSU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=khiTEHYqYsxOcSdaCoJ91H1LAzSeWB8fYeqVCzLWrBJitB5UreBgbqsmAQykPVle1WTbk+9mYk3tBx2g1cnG6NfRmq5+qJmTk8DemAlDGLVrx+EzV3/dDMNsnhoNw9g/eEf2PjU8jwXqtL34REJHiNpaONO+cL5fCeNveVjk/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpFM8mJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAC9C4CED2;
	Wed, 11 Dec 2024 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733926943;
	bh=haNvrp7vfLxxotz4/f+JScoeb3XX4wNKAxfWcxSqFSU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YpFM8mJzXRhEs+FqLTxtHNEGG2DKcKeAwuq1HPK0wXYU9j/dZEHoevZx3MRZTxyMo
	 s90bq26S+hbpUO3OJGID3nPDojFva11XbuJ58eNei6CMaQvrJDkivahehw4AgifRje
	 ucOju9dWI6XNTf6y2ji+DJwCgcr7FAVXXkQZrIatyGvi9fAqrE9x3a4+VhriOSrHHg
	 wLUgnT4UoVn07/W3m61gLyZOdiFEyk80Z4oXYnPIB08WZcw847W11FMZU5QSOVq26Y
	 2OrKQwb+eUCTJc0+tMYjMbn6QVfqL9Zyfm/EHhRzVe6UGL5c8mFXeYE9vRvpRGMd89
	 1y+8ithTqsI0g==
Date: Wed, 11 Dec 2024 08:22:21 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, broonie@kernel.org, javierm@redhat.com, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org
To: Iker Pedrosa <ikerpedrosam@gmail.com>
In-Reply-To: <20241211134023.222473-1-ikerpedrosam@gmail.com>
References: <20241211134023.222473-1-ikerpedrosam@gmail.com>
Message-Id: <173392694152.2841548.6324601669086826713.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: devicetree: explain how to get CS
 active-high


On Wed, 11 Dec 2024 14:40:17 +0100, Iker Pedrosa wrote:
> The current documentation does not clearly explain how to invert the SPI
> CS signal to make it active-high. This makes it very difficult to
> understand.
> 
> This patch adds a simple explanation on how to set the CS line in
> active-high and adds an example to make it easier for users who need
> that setup for their SPI peripherals.
> 
> Link: https://forums.raspberrypi.com/viewtopic.php?t=378222
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  .../bindings/spi/spi-controller.yaml          | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/spi/spi-controller.example.dts:82.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/spi/spi-controller.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241211134023.222473-1-ikerpedrosam@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


