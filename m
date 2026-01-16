Return-Path: <linux-spi+bounces-12451-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39428D38733
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 21:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C885E3074E69
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 20:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE53399A45;
	Fri, 16 Jan 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zKhdmH5M"
X-Original-To: linux-spi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F93A1D1A;
	Fri, 16 Jan 2026 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594321; cv=none; b=efwRC7B+/nCnctcQ85kILljMV3yVJ1BA5rIdNRwGjhnYBo8mWal8Jrye6F92SJce2Zo5UUqo7QJilR/jJ6a1CJQhcoeLNEf921evL49Lof2d48wIAGx/4aU8fdcmrX2vLRmwJ0LXYHwjdCEApYfwFxcK+RCb2Y3yh/D0/xmckQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594321; c=relaxed/simple;
	bh=HL2Y0yXehTTEDhxdz9ZjJPx6tKsEADBox3tOg+oM3Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNrS/xHMYoIQIBqm5Uoi560IojmFgHFSJWwi57BsAmt3g/QYv/YnrVHiyv28aJTfNnZTl5OtIRUGOvY2uQ37VK3Y8wp8deDfCtU4qsrP66nMdD6mlExTdjHBzTJXzNvN6X4c6h0quPs+C/QpGFtUrqHcViTeZExzJCVZiN7fhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zKhdmH5M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yG1gxdLIiczbqATL2il7iM6aKwGQj0684D9Q9eoZBXU=; b=zK
	hdmH5Mi0C8gQkomOnTXRgoiMXkxBVgVi1vUCdIiIvjxyfCTn4jcy/bxVXL3PXM6MHlWmZp3Olold4
	4tDxgR914dDj1SAnmf49vZPXvefkEnew1jidJvURuoLkwli4994+ZPKD7tp+xVTF0TytFAqeNrtgl
	+4XERhJ9jH7IGPk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgqAf-0037BL-7s; Fri, 16 Jan 2026 21:11:49 +0100
Date: Fri, 16 Jan 2026 21:11:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: xilinx: use device property accessors.
Message-ID: <608a92f1-9403-45c8-b4bf-085f85876aad@lunn.ch>
References: <20260115003328.26095-1-abdurrahman@nexthop.ai>
 <12f527c6-7728-4512-a4f1-08c778627ea8@lunn.ch>
 <87C51F3B-7770-4BFA-8BBC-5E83A71920E1@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87C51F3B-7770-4BFA-8BBC-5E83A71920E1@nexthop.ai>

On Fri, Jan 16, 2026 at 12:00:35PM -0800, Abdurrahman Hussain wrote:
> 
> 
> > On Jan 16, 2026, at 7:23 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> > On Thu, Jan 15, 2026 at 12:33:28AM +0000, Abdurrahman Hussain wrote:
> >> This makes the driver work on non-OF platforms.
> >> Also, make irq optional, since the driver can already work in
> >> polling mode.
> > 
> > Are you saying ACPI cannot describe interrupts?
> > 
> >    Andrew
> 

> It can. We have enabled the interrupts through ACPI on Xilinx I2C
> block and it works great.  For the SPI block we currently have an
> issue with our FPGA. Luckily the driver works just fine in the
> polling mode. By just making the interrupts optional makes the same
> driver usable on a wider range of hardware platforms, with or
> without the interrupts.

It would be good to split this change into two patches, one making the
interrupt optional, and one swapping to device_foo calls. They are
logically different changes. And the commit message can then explain
you are doing this so the driver works with hardware with broken
interrupts.

Actually, you need three patches, you need to change the DT binding,
spi-xilinx.yaml, since currently interrupts are required, not
optional.

       Andrew

