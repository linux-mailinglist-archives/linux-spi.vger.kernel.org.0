Return-Path: <linux-spi+bounces-1765-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E68785A4
	for <lists+linux-spi@lfdr.de>; Mon, 11 Mar 2024 17:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FCF1C21B91
	for <lists+linux-spi@lfdr.de>; Mon, 11 Mar 2024 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32E842073;
	Mon, 11 Mar 2024 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b="NwrT95r1"
X-Original-To: linux-spi@vger.kernel.org
Received: from sirabella.org (sirabella.org [207.246.81.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA742076
	for <linux-spi@vger.kernel.org>; Mon, 11 Mar 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.81.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175395; cv=none; b=VF4lmqRUknSuv8PS4jB62TeWagW/qbq//Zix7mHe/txwWGlRcHljcgxFDUr4KDRKfHHrxkGImocqNx1NjSaoyahR+Cpb1kWUQdhCXEuOZJ6cCahWs1F3hMZXvCporPyiAJsQXFc5+TxnRRYDtd6dTLAyz33qHvaLa5Zn4W0eCQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175395; c=relaxed/simple;
	bh=OOpMXFRHYh5QmU82CMK5ExE1YQcHbcNAuVShSZYN7Io=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O0H4Hl4ULvCtdutzXoTeFzs+AkJPK0S9ecBt1QITnfjZDsVsXTnTaG+ytrOMgj2pkxwfjLTZ/119rtlOK9n0Ji8DY0FMnBwCFyl0yY+lma8KJvVyWGRM220WCxwCuxdi4S5S7ZbWT4GM+TJR8doCN4OLX+nLpsSizvxM+E6Kb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org; spf=pass smtp.mailfrom=sirabella.org; dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b=NwrT95r1; arc=none smtp.client-ip=207.246.81.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sirabella.org
Date: Mon, 11 Mar 2024 09:42:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sirabella.org;
	s=mail; t=1710175386;
	bh=xUulZqFzk7zWFr7BiOrCasF9WZksilrabv7QbmirC60=;
	h=Date:From:To:Subject;
	b=NwrT95r1Vat0HAVI9jglmsnNXz3YBXKwdNIbZkq1W0wB8ReMmyrWP9oaIilFLLJPf
	 EicN0gwjdvu1TFFDt4ars7HjbAlyglvz8y6zfj8S9dDMhwvWLTWMZswsVe8lLWCByr
	 MxkZrL0/21RL52VsV+qDoBNx44TuYjqcfZpdJNYE=
From: Marco Sirabella <marco@sirabella.org>
To: linux-spi@vger.kernel.org
Subject: use_gpio_descriptor with a runtime-added table
Message-ID: <20240311164231.ve3tlx6ib6raeo7m@Ne0Ridl3y>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/markdown; charset=us-ascii
Content-Disposition: inline

Hi,

let me know if there's a better place to ask for help.

I'm registering a controller and trying to take advantage of:

    master->use_gpio_descriptors = true

but the gpio table with the auto-lookup "cs" is being registered at
runtime with gpiod_add_lookup_table (kind of like how spi-bcm2835 does
it).

My issue is basically that table.dev_id doesn't have a value that it can
be set to until halfway through the devm_spi_register_controller call
with the dev_set_name and by then I can't update the table's dev_id for
it to be found via the gpio handling in the second half of the
register_controller call.

My current workaround is to statically assign a master->bus_num and use
that but I'm pretty sure that's not what it's intended for.

Any tips? I have a patch that might fix this but don't want to jump the
gun if I'm just doing something wrong.

-- 
Marco Sirabella

