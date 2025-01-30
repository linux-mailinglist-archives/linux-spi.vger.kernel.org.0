Return-Path: <linux-spi+bounces-6584-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183AAA229F0
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 09:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186873A263E
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821EF1B392A;
	Thu, 30 Jan 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Y+DyFbpE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6AC374CB;
	Thu, 30 Jan 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738227512; cv=none; b=Lkm1D7qjlaGCjNBhIFN5/rXYNwfGl8BMe2+UmKyCAl9RhuHLXBIrrQwM+KpN23aCv8u7zDu3b56b4SwW+zLmJmv/wbEtD4FH9L+cvwSKCrAyAiTebH2WH05WbudfnuoX22JszE+CmdqAGIf8z3Hg7rjhWr5nhh0Z+tjCeJptDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738227512; c=relaxed/simple;
	bh=hOOMYIP8DARAq2ocHWO0iuHeti8oklCLy+QHpJ9s/iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IT/n6b2Oh7ljApzuMd5GTrXQc5vA9/YHiyZuyK/UdSj2ozD1zQdpWhSJKJYg+KTO94uB3pa3aZYprxQPUV5B6VMJz0T58IJDzAOfGENTGBVwjeExjecqbDfSQmXT7pPgHu3qTywzc8qF3q9ETatrnzSbO0SqoUDWpcsnW66WKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Y+DyFbpE; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U6Q0Y6018023;
	Thu, 30 Jan 2025 09:58:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	pVHdPHZta182pa00CYYtJOzM1kMJtrB33zkyMPcHloY=; b=Y+DyFbpE7xKRstU1
	GV36Maqi+BgyjILcGzcMzVi3eYPOiU52JGmciFtAO9ktuipMEIkh6Ih5EXixAtFu
	UD5lc9+XvALvTxT9iugUoXpi6hMdBXeNrEze47unC42NZ0lzAtGkSZfvX6o6bunz
	BuuOyYqgnv7agXA2XdNCXdptBrGJJsYZbAp9VGpRLK34fDMDPFKvtvihvQS4/QQT
	nuwTcZ/TFVssjycjXXN5I2izNP1ljKOuVBwB1lVwgyI9yQq6Xgqr4NwFajllkVAv
	80lUrGl98dPDruqQlo+6O6SO3wUR+UdCAQjfsbcZYheQitUTQg1HPLrs3gIva9Wm
	eT/Yaw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44f26x6wca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 09:58:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 675A540044;
	Thu, 30 Jan 2025 09:56:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F12E72D5869;
	Thu, 30 Jan 2025 09:55:47 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 09:55:47 +0100
Message-ID: <4ea55395-e4e2-425e-9711-3c99f30a9fa9@foss.st.com>
Date: Thu, 30 Jan 2025 09:55:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] spi: stm32: Add OSPI driver
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-3-patrice.chotard@foss.st.com>
 <ec35dbd3-5730-4cc8-8025-d349740d1ba5@sirena.org.uk>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ec35dbd3-5730-4cc8-8025-d349740d1ba5@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_05,2025-01-29_01,2024-11-22_01



On 1/28/25 13:37, Mark Brown wrote:
> On Tue, Jan 28, 2025 at 09:17:24AM +0100, patrice.chotard@foss.st.com wrote:
> 
>> +static int stm32_ospi_tx_poll(struct stm32_ospi *ospi, u8 *buf, u32 len, bool read)
>> +{
> 
>> +	if (read)
>> +		tx_fifo = stm32_ospi_read_fifo;
>> +	else
>> +		tx_fifo = stm32_ospi_write_fifo;
> 
>> +		tx_fifo(buf++, regs_base + OSPI_DR);
> 
> It feels like the _tx_poll and tx_fifo naming is a landmine waiting to
> surprise people in the future.  The code sharing makes sense but the
> naming is just looking to cause surprises, especially with it just being
> a bool selecting read or write.

Agree, i will replace "tx_fifo" to a more neutral name as "fifo" for example

> 
>> +static int stm32_ospi_tx(struct stm32_ospi *ospi, const struct spi_mem_op *op)
>> +{
> 
>> +       return stm32_ospi_tx_poll(ospi, buf, op->data.nbytes,
>> +                                op->data.dir == SPI_MEM_DATA_IN);
> 
> Though the one caller is also using _tx only naming, it's a bit more
> tied in with the op sending though.

I will replace stm32_ospi_tx_poll() by stm32_ospi_poll()

> 
>> +	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
>> +			  SPI_TX_DUAL | SPI_TX_QUAD |
>> +			  SPI_TX_OCTAL | SPI_RX_OCTAL;
>> +	ctrl->setup = stm32_ospi_setup;
>> +	ctrl->bus_num = -1;
>> +	ctrl->mem_ops = &stm32_ospi_mem_ops;
>> +	ctrl->use_gpio_descriptors = true;
>> +	ctrl->transfer_one_message = stm32_ospi_transfer_one_message;
>> +	ctrl->num_chipselect = STM32_OSPI_MAX_NORCHIP;
>> +	ctrl->dev.of_node = dev->of_node;
> 
> It looks like the controller only does half duplex as well so it should
> set SPI_CONTROLLER_HALF_DUPLEX.

Right, i will add it.

Thanks
Patrice

