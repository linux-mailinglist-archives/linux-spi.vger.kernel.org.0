Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED57253B68B
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jun 2022 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiFBKEM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jun 2022 06:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiFBKEL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jun 2022 06:04:11 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE6115A44;
        Thu,  2 Jun 2022 03:04:08 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25284Kim018004;
        Thu, 2 Jun 2022 12:03:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=m0BCmY6bXRbzWS6fl2Ve4Vs/Ccc1sRTGBDBIBXY+c6I=;
 b=WuSnLnG4D/Nyv0VWP2j0eZCiGe4+MtuCxmfGBXIjUuT300iA5DMyBu16vgOYMMXyuzVZ
 /wQJJN9wdjxKbCkgows4BOhXmAhImz6jd1ozt1CVmbruf6v0PEyy0mCAIWf9rOrV8Ys8
 O8AHt1liciMBHMmpD/YyaGwY/O8Rndmcv1ovlDCsScNq8Cbg73Qcm/mdJNV0oeVqVP3h
 8nY9oQRFPcE5npbIjJWu6zG0ifPk9Rw0/CP/B9YGDBnQC1Hl/tRE6jCrO0GyWAb3EDIz
 hGEouAukzQj+qjQKmiDUd9P4ZAfsdQecyTUlRvPo8wdzsDwCOQlKGQqMC+dqeWcTc6Nu Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gbc2vy4kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 12:03:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7BFB10003A;
        Thu,  2 Jun 2022 12:03:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2432E21A20C;
        Thu,  2 Jun 2022 12:03:51 +0200 (CEST)
Received: from [10.211.11.162] (10.75.127.48) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 2 Jun
 2022 12:03:50 +0200
Message-ID: <63e621b9-78e8-e53c-21dc-b1011ea2a15b@foss.st.com>
Date:   Thu, 2 Jun 2022 12:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] spi: stm32-qspi: Remove unused parameters
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20220602085918.350613-1-patrice.chotard@foss.st.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220602085918.350613-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_01,2022-06-02_01,2022-02-23_01
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

A v2 as been sent, as a patch was missing

PAtrice

On 6/2/22 10:59, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> This series cleans up spi-stm32-qspi driver by removing unused parameters
> 
> Patrice Chotard (2):
>   spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
>   spi: stm32-qspi: Remove stm32_qspi_wait_cmd() unused parameter
> 
>  drivers/spi/spi-stm32-qspi.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
