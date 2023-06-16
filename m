Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C469733338
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jun 2023 16:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjFPOMp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jun 2023 10:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFPOMm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jun 2023 10:12:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37273270B
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 07:12:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GAxsu0011762;
        Fri, 16 Jun 2023 14:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NiREWQ4QHMN3MzVJg5J4ifFYBrqCZ/hkhW86SbKQDG0=;
 b=B0BmBXqOBK+oAEpfYzvp8i3ACiojFthdUrZzD1q/pPlvlxRxM5PwbONNAt4kvYhUFaiA
 3/YSpNMilImZfN7Bh3FWdOWw0BpycqbdVDxPDBFYLrMPGh4CoJuXzLQ2DZT/4FEEwqbf
 Thh2YXqiXTF1J/EZG9rNy/KwNHg2kB3mrmepMAlZ0SwvWDAUTeGSiAFWboMxSLN6YNDO
 tVstocpFIrRUlaGLzE9evBe6Fre9SjR2ckGb38IfzbqE5JekDVyU9NSwYc4+QZxKfVJA
 iBvpgwVuvuxCjCIBCicJQR6EZ5cgQhuZCRhuXf+gmi534LkEOGItPgKW+1YRFkvTuV4y ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8abb1kyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 14:12:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35GECZx6027999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 14:12:35 GMT
Received: from [10.216.15.132] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 16 Jun
 2023 07:12:33 -0700
Message-ID: <a244d741-02bb-9d74-0a6c-1f01a6eeb360@quicinc.com>
Date:   Fri, 16 Jun 2023 19:42:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bug report] spi: spi-qcom-qspi: Add DMA mode support
Content-Language: en-CA
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     <linux-spi@vger.kernel.org>, Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
References: <abc223e8-44af-40bb-a0bd-9865b393f435@moroto.mountain>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <abc223e8-44af-40bb-a0bd-9865b393f435@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HpXsB9gbyO7Wiwgi3Jc-ScfwjDsewn3q
X-Proofpoint-GUID: HpXsB9gbyO7Wiwgi3Jc-ScfwjDsewn3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=876
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160128
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Dan,


On 6/16/2023 6:12 PM, Dan Carpenter wrote:
> Hello Vijaya Krishna Nivarthi,
>
> The patch b5762d95607e: "spi: spi-qcom-qspi: Add DMA mode support"
> from Apr 24, 2023, leads to the following Smatch static checker
> warning:
>
> 	drivers/spi/spi-qcom-qspi.c:368 qcom_qspi_setup_dma_desc()
> 	warn: sleeping in atomic context
>
> drivers/spi/spi-qcom-qspi.c
>      336 static int qcom_qspi_setup_dma_desc(struct qcom_qspi *ctrl,
>      337                                 struct spi_transfer *xfer)
>      338 {
>      339         int ret;
>      340         struct sg_table *sgt;
>      341         dma_addr_t dma_ptr_sg;
>      342         unsigned int dma_len_sg;
>      343         int i;
>      344
>      345         if (ctrl->n_cmd_desc) {
>      346                 dev_err(ctrl->dev, "Remnant dma buffers n_cmd_desc-%d\n", ctrl->n_cmd_desc);
>      347                 return -EIO;
>      348         }
>      349
>      350         sgt = (ctrl->xfer.dir == QSPI_READ) ? &xfer->rx_sg : &xfer->tx_sg;
>      351         if (!sgt->nents || sgt->nents > QSPI_MAX_SG) {
>      352                 dev_warn_once(ctrl->dev, "Cannot handle %d entries in scatter list\n", sgt->nents);
>      353                 return -EAGAIN;
>      354         }
>      355
>      356         for (i = 0; i < sgt->nents; i++) {
>      357                 dma_ptr_sg = sg_dma_address(sgt->sgl + i);
>      358                 if (!IS_ALIGNED(dma_ptr_sg, QSPI_ALIGN_REQ)) {
>      359                         dev_warn_once(ctrl->dev, "dma_address not aligned to %d\n", QSPI_ALIGN_REQ);
>      360                         return -EAGAIN;
>      361                 }
>      362         }
>      363
>      364         for (i = 0; i < sgt->nents; i++) {
>      365                 dma_ptr_sg = sg_dma_address(sgt->sgl + i);
>      366                 dma_len_sg = sg_dma_len(sgt->sgl + i);
>      367
> --> 368                 ret = qcom_qspi_alloc_desc(ctrl, dma_ptr_sg, dma_len_sg);
>
> The qcom_qspi_alloc_desc() is a sleeping allocation, but the caller
> qcom_qspi_transfer_one() is holding spin_lock_irqsave(&ctrl->lock, flags).


I think We should be able to move qcom_qspi_setup_dma_desc() , and thus 
qcom_qspi_alloc_desc(), out of critical section.

Right now we are looking into some issues with DMA mode transfer that 
have showed up recently and will likely have a Fixes: patch next week.

Can we include this change in same series?

Another option is to include flags __GFP_ATOMIC in call to 
dma_pool_alloc() and upload a Fixes: patch right away.

Would that work?

Can you please advise?


Thank you,

Vijay/


>
>      369                 if (ret)
>      370                         goto cleanup;
>      371         }
>      372         return 0;
>      373
>      374 cleanup:
>      375         for (i = 0; i < ctrl->n_cmd_desc; i++)
>      376                 dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[i],
>      377                                   ctrl->dma_cmd_desc[i]);
>      378         ctrl->n_cmd_desc = 0;
>      379         return ret;
>      380 }
>
> regards,
> dan carpenter
