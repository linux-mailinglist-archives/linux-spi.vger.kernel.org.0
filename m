Return-Path: <linux-spi+bounces-12515-lists+linux-spi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-spi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lMcFAlCnb2nxEgAAu9opvQ
	(envelope-from <linux-spi+bounces-12515-lists+linux-spi=lfdr.de@vger.kernel.org>)
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 17:03:28 +0100
X-Original-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D084703E
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 17:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A3639C1CB0
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EBE44D686;
	Tue, 20 Jan 2026 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oaYWcXbs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AD2F533E;
	Tue, 20 Jan 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921545; cv=none; b=mw9eMWO810NzisIoK481rA+GgRvc0i4fXFJuuRbZ27YQ6K1CAI9kmwGqyfdszxB6C1lDQSbZk0Z6woD1kThhZx+KR6hQ5W9tC+W9UEf3Uo5UpVvXPASRFkUNvipM7bsks0fSPz9ACCM6zNp/TP9gdMXxskz5mv4wCR8Kqn30p5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921545; c=relaxed/simple;
	bh=0ler8iCtqk2EiGfm/2ocxMEnXXml/ihrwsqRs5L067M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6a7M/K9uTkyExHTJHbG5rAMMlmErIkn0j+FHJAUDkipJEmrijDmCmJzJieHIDAUedvbFj2vnbkUm/UGfvUhmRykchIt16HbuBElijq0vn28LJJ787iUW4+5kJ5dRwqM09vo7wKhszeX2/7QpF1+jW66YW6C16Jx0cGgM6JKekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oaYWcXbs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8EEE91A2973;
	Tue, 20 Jan 2026 15:05:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 62337606AB;
	Tue, 20 Jan 2026 15:05:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FF8B10B6943D;
	Tue, 20 Jan 2026 16:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768921540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g12cAMZNPPtUUPqHd1kwBTs8XQb3e9bnrWcT2IaKQyg=;
	b=oaYWcXbsd4xRk588Tj9Z0c2I8AIf1b2pBiPrk3C+vTgsUfvrKVkgx7S3SyYVauN66Vi1uK
	rp3hkKpJv0D7y7S9sWd6KXau6mev7uMm6590rS0t25cBNpvJsbOqhMNHyO8FlycPakn8cp
	jv6J03DfnHP/5lycRu4WZ0UAieIPF2XGyjYv96FjHRxVJbNHmVIg3HGMMMUJC9gNoeW7av
	tFj3Tqly0nfBaqDI6jdtn0WMneBbuF+upADv+1Z01BojfDQTNdi5Uu0FStQv/YH9qRO6sX
	lEy+nDaqk1cljv+VjOJH2IOHjtZ6Dbx8MoMQJsPvebjwW386W8xERbkJiThmbA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: "Mark Brown" <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  "Geert Uytterhoeven" <geert+renesas@glider.be>,
  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav Achath
 <vaishnav.a@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  =?utf-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,  Pascal Eberhard
 <pascal.eberhard@se.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 00/13] spi: cadence-qspi: Add Renesas RZ/N1 support
In-Reply-To: <80e7a578-4636-48bd-b92b-54fa33cc076d@ti.com> (Santhosh Kumar
	K.'s message of "Tue, 20 Jan 2026 14:52:38 +0530")
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
	<80e7a578-4636-48bd-b92b-54fa33cc076d@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 20 Jan 2026 16:05:35 +0100
Message-ID: <87cy34s4sg.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,ti.com,bootlin.com,sang-engineering.com,se.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-12515-lists,linux-spi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,linux-spi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-spi,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,ti.com:email]
X-Rspamd-Queue-Id: 80D084703E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Santhosh,

On 20/01/2026 at 14:52:38 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Hello Miquel,
>
> On 15/01/26 14:54, Miquel Raynal (Schneider Electric) wrote:
>> Hello,
>> This series adds support for the QSPI controller available on Renesas
>> RZ/N1S and RZ/N1D SoC. It has been tested with a custom board (see last
>> SPI patch for details).
>> Adding support for this SoC required a few adaptations in the Cadence
>> QSPI driver. The bulk of the work is in the few last patches. Everything
>> else is just misc style fixes and improvements which bothered me while I
>> was wandering.
>> In order to support all constraints, I sometimes used a new quirk (for
>> the write protection feature and the "no indirect mode"), and sometimes
>> used the compatible directly. The ones I thought might not be RZ/N1
>> specific have been implemented under the form of a quirk, in order to
>> ease their reuse. The other adaptations, which I believe are more
>> Renesas specific, have been handled using the compatible. This is all
>> very arbitrary, and can be discussed.
>> Thanks,
>> Miqu=C3=A8l
>> Signed-off-by: Miquel Raynal (Schneider Electric)
>> <miquel.raynal@bootlin.com>
>
> Thank you for the series! Tested it on TI's AM62A SK with
> OSPI NAND (Winbond's W35N01JW).
>
> Controller fails to probe with the following message:
>
> [    1.868863] cadence-qspi fc40000.spi: Cannot claim mandatory QSPI ref
> clock.

Strange, I was nonetheless careful not to change the existing
behaviour on other SoCs. I have that board, I will give it a try.

Thanks a lot for the feedback.
Miqu=C3=A8l

