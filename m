Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C02116AF3
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 11:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfLIK1V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 05:27:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57594 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLIK1V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Dec 2019 05:27:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9ARI8O102027;
        Mon, 9 Dec 2019 04:27:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575887238;
        bh=HurSSoFwbB+tpbxZNTJI9RuisQvDyAMeDgjSx93Qiys=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZhgKPkB1ewkuJlSXQ8WeOfjbbomJrnhshK5RCHn42iPtBIu2WOHvQIUVN8etVCW5h
         RMJm3xVmGt73DL8w/WJmcoAImeKzA/nU64OP1ttgv+ayM4YXYQJE47KTzQBSPlUUgz
         DKZlPLVhdEpAk+3t33qDsictqv7vVVAgq9gnScGo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB9ARIB4104929
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 04:27:18 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 04:27:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 04:27:17 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9ARF4Y075274;
        Mon, 9 Dec 2019 04:27:16 -0600
Subject: Re: [PATCH 2/3] TI QSPI: support large flash devices
To:     Jean Pihet <jean.pihet@newoldbits.com>,
        Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-omap@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-3-jean.pihet@newoldbits.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <2ea31c73-13ee-a51e-e8b7-69cbe3b83c43@ti.com>
Date:   Mon, 9 Dec 2019 15:57:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206160007.331801-3-jean.pihet@newoldbits.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 06/12/19 9:30 pm, Jean Pihet wrote:
> The TI QSPI IP has limitations:
> - the MMIO region is 64MB in size
> - in non-MMIO mode, the transfer can handle 4096 words max.
> 
> Add support for bigger devices.
> Use MMIO and DMA transfers below the 64MB boundary, use
> software generated transfers above.

Could you change the $subject prefix to be "spi: spi-ti-qspi:"


[...]

> -574,6 +601,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
>  
>  static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
>  	.exec_op = ti_qspi_exec_mem_op,
> +	.adjust_op_size = ti_qspi_adjust_op_size,
>  };
>  
>  static int ti_qspi_start_transfer_one(struct spi_master *master,
> @@ -599,12 +627,11 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
>  	frame_len_words = 0;
>  	list_for_each_entry(t, &m->transfers, transfer_list)
>  		frame_len_words += t->len / (t->bits_per_word >> 3);
> -	frame_len_words = min_t(unsigned int, frame_len_words, QSPI_FRAME);
>  
>  	/* setup command reg */
>  	qspi->cmd = 0;
>  	qspi->cmd |= QSPI_EN_CS(spi->chip_select);
> -	qspi->cmd |= QSPI_FLEN(frame_len_words);
> +	qspi->cmd |= QSPI_FLEN(QSPI_FRAME);
>  

Hmm, change itself is harmless. But what is the motivation behind the
change?

>  	ti_qspi_write(qspi, qspi->dc, QSPI_SPI_DC_REG);
>  
> 

-- 
Regards
Vignesh
