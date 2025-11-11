Return-Path: <linux-spi+bounces-11161-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE768C4EF44
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 17:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAEF18C301C
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1436B073;
	Tue, 11 Nov 2025 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5wcdImD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B633556E;
	Tue, 11 Nov 2025 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877651; cv=none; b=YlufL1VKa5IySp4e6uWas4X95279/Uf0zjPvGdhydhlSAfIrZ7pTWwfpDMVsHPWUBucnG5QMy1wAoGHGLT2tegjMVmUlyVfDmi02NZNeLbFvJdECp3jWrRYXgXRT0b4E/JPcKLXSgi3DNVOH3Zg66jLijHZTPxLlpcOJkjy9CAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877651; c=relaxed/simple;
	bh=rKuraMxsrbsZcrLfC4Ao1ior3+JXNK/ji1oPIQxDgOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+X1EPyZvq+hW4t5oCTYSvgy0WbofI160WCVZvE6T56l3YcKcJ52RJdRvKTxsxxKayIVbK/Q9okP2GXce3WqgjbB/pEkq/UT7XQPJfv4bTeklWbAEfG2sq+aQAakh+EZgYx5P4V42l0Dn3nHTmW9ws75si/Zi0DCDnz2FFYCIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5wcdImD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA057C19421;
	Tue, 11 Nov 2025 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762877651;
	bh=rKuraMxsrbsZcrLfC4Ao1ior3+JXNK/ji1oPIQxDgOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5wcdImDYU2/nFXMnUcIDAb5XS41qFc+EwBQw8sqTJkUI72wjGzzRCdD+4xu0qs/n
	 BjOHxDYmPWu1zT/ZzqxMd7s7NiaFnhAxLNBVMbUP9CKnk+RnIZcD1ZRzJQKQS2G9lW
	 57F+ztXjUfq+hmEGQysuPXz1GJ5xe26dLmO9PXcIiZoB/PxFMjcoOobg075R8lTT/x
	 HhIFtdxhYmqRsbm5fdO/4nDYU4daaQ2kAOBGUexm/PTmzT/+ZmzEBR7YoGrVQRgWjn
	 CLL7hCCxwiLxTuGO3LoTl5JAU2zV+7kep85Zd1iIdAl+xdy7i48h7OZhe7vxfrCGTP
	 P1TM6fH7MBD+w==
Date: Tue, 11 Nov 2025 10:18:22 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Riccardo Mereu <r.mereu.kernel@arduino.cc>, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, broonie@kernel.org, linux@roeck-us.net, 
	Jonathan.Cameron@huawei.com, wenswang@yeah.net, naresh.solanki@9elements.com, 
	michal.simek@amd.com, nuno.sa@analog.com, chou.cosmo@gmail.com, 
	grantpeltier93@gmail.com, eajames@linux.ibm.com, farouk.bouabid@cherry.de, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, mm.facchin@arduino.cc, Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH 3/5] dt-binding: arm: qcom: add arduino unoq codename
Message-ID: <jjzeljmhwaem4uiz76ec3wlijtej6xz6qzxxr6v22g2ioy6mqg@rdm4ibk5puld>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
 <20251106153119.266840-4-r.mereu@arduino.cc>
 <2c67a82a-3a4a-44e5-8c82-42ec6320d5b5@kernel.org>
 <fuz3se3hwtoqlgcifo35qozda5xy2gneatm64f5nsq6n75jteo@vqbu7naldfgq>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fuz3se3hwtoqlgcifo35qozda5xy2gneatm64f5nsq6n75jteo@vqbu7naldfgq>

On Tue, Nov 11, 2025 at 02:27:03PM +0200, Dmitry Baryshkov wrote:
> On Fri, Nov 07, 2025 at 08:13:48AM +0100, Krzysztof Kozlowski wrote:
> > On 06/11/2025 16:31, Riccardo Mereu wrote:
> > > From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
> > > 
> > > Document Arduino UnoQ. Arduino UnoQ is a single-board computer
> > 
> > compatible says imola, not unoq.
> 
> And compatibles for various ChromeBooks also use codenames. I think it's
> not the first time the vendor uses a codename instead of the marketing
> name inside the compat string.
> 

I appreciate the use of the codename, but both subject and commit
message is talking about "UnoQ" only and then "imola" shows up only in
the patch.

@Riccardo, please introduce "imola" in the commit message, so we know
what it is.

Regards,
Bjorn

> > 
> > > combining Qualcomm Dragonwing™ QRB2210 microprocessor with
> > > STMicroelectronics STM32U585 microcontroller.
> > > 
> > > Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
> > > ---
> > 
> > 
> > Please use subject prefixes matching the subsystem. You can get them for
> > example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> > your patch is touching. For bindings, the preferred subjects are
> > explained here:
> > https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> > 
> > 
> > Best regards,
> > Krzysztof
> 
> -- 
> With best wishes
> Dmitry

