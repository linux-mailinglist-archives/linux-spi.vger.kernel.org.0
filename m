Return-Path: <linux-spi+bounces-12446-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ACFD332EA
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 16:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2103430AEE3B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BC631AAA7;
	Fri, 16 Jan 2026 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sQkCIrL3"
X-Original-To: linux-spi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A451A316E;
	Fri, 16 Jan 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577014; cv=none; b=AfwJRF7nOltfOU8Iuw+fNH79bebCTipMoF9o3EXnw71b2gkWlEdw0SMPbJmnevvo2SXWB8m1iJ4eB4sMaqeKjWPxr3UmwF/n0uhdQh3hAqzksWrhP3m/XdLhY5J8sJ+dXWmBfrOyrMy4j/0SsDCa1eYk94f2LOASZvSOFVin4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577014; c=relaxed/simple;
	bh=H/U3z7IKaks6UVO8HMhgeDXnkaldNZ2TN41y01E4zK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fphFU54JJ/uJAfUTaolzYxGu7EBVy0G9vbyQRI4Lsf0zz1crIRzbB8BEYeBgCMuc7mgJm7CR4S8AeIoZdOXhJV+vHLerVLdhdbku0qABYIye0GP93WRS4r4nHyL07NoV3ToGecWQ34++zaVTeRM7ND0tBI6eJbl4uUFZBfsGQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sQkCIrL3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SAL69x+aMsb3wJrvEhrX3q6+5c3rIZOTW1Qes4NnKM4=; b=sQkCIrL3ScL+xhdccTjGbKqBDL
	z4f2Qb/CMhImQ9NrzsrrK+6g52BTgnTHgtWxUysj3Vnk6YmEcodT7DifKUiZmcr8JsD3nzb+PE5yA
	xt+CkU+Up5VpU0pfaUKF0rL7OQ0nK9RIVCixuIoKnV5+zT2fxN2TA/qmNjM7x+NIfLwM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vglfY-0035ZG-OV; Fri, 16 Jan 2026 16:23:24 +0100
Date: Fri, 16 Jan 2026 16:23:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: xilinx: use device property accessors.
Message-ID: <12f527c6-7728-4512-a4f1-08c778627ea8@lunn.ch>
References: <20260115003328.26095-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115003328.26095-1-abdurrahman@nexthop.ai>

On Thu, Jan 15, 2026 at 12:33:28AM +0000, Abdurrahman Hussain wrote:
> This makes the driver work on non-OF platforms.
> Also, make irq optional, since the driver can already work in
> polling mode.

Are you saying ACPI cannot describe interrupts?

    Andrew

