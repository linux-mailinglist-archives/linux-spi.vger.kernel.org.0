Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D793C5A165F
	for <lists+linux-spi@lfdr.de>; Thu, 25 Aug 2022 18:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiHYQJa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Aug 2022 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbiHYQJY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Aug 2022 12:09:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FF1B941A
        for <linux-spi@vger.kernel.org>; Thu, 25 Aug 2022 09:09:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PFd9Hg004536;
        Thu, 25 Aug 2022 16:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=ej13FYXCJHaQ8g9ak43S1Qh5caJZj3zZ/C9k9rz8aKo=;
 b=mtmHVSUXQgNNjCr1LRF96U/LKNc6KvVj7xlDOl8EtBAuz+tMkFRMlIQPpQC/azywg77I
 G5u6OLjODD9miy/OcyEBG54wzXjPpLHE/D7u52AtvaPO/wNctRJYNGTxEWg/PZlKb2HA
 iKyfWjFuTSzTnl9lM7QJervanpkYLhYexdlMPV4JuEqrmId0f+4nR6EKYoV985yjrOsV
 ZO7YhlMAey4XJ+L2BH5No4dIqpBw4luWicW3aweM/4te7iqZjKgFdvJeM7Vq3yCmGU9M
 qgsItAQbsU+++oCvAI96SfmeL+Ej4BYAUbyyyJTI0jACoKYGqLVARfyHcjmlvdiejBiy Nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nydbu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 16:09:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PFJIlE016725;
        Thu, 25 Aug 2022 16:09:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n57sfk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 16:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dobgP9unWLJ5fDQvQN9TFCbJ8fqSuaExW6ZqZvQbU0mvNoD5oxgAY/zZ7kXY0OEzvK4whZG6Zj+uDETFKw22AG5zC8MiNy3AcO1mkZsTprXeFeC6HodQTHCFNy5TDCBhkYp7KBxJ696S49ArtvusGSY26xUYOFkvSXVTbBgEuS3yCHKTtEvpkETkcV8t8Lss4e+ZfZ2JSXiEdWDXq1P8aha+SWooF9FIBl+1PambdjYl2shaNRDlmaUnToB/85KBIOU/f4noYTbctV6Z9IsRqaJxkDuE4qWVNCuUo4MAgsjjlzfjr+YqkLyIjVODuQSttdS3TGn8dduoxeUnyKQAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej13FYXCJHaQ8g9ak43S1Qh5caJZj3zZ/C9k9rz8aKo=;
 b=gE3wGY555e/nSHtfNvlq78nelyqdgDVauxgjDwd9LTQMMpTQOI0SSp4GiNOcELvhzihlap+B14w/HnzWbMcmdWoOaKQdGkVDJIn8cmAnKitUhJvInDr9oh/cQQP4QeXiJTIB+Tcs5TzbLYTNPDJfphMdXhaQ/N4NKqIUcmtBGXYze9htpBqMGuJg3iPJM+5GWcY6vUCgiz2A/Qm468N09mlFSJ66ppTMJEN76A/1vzukQ/yicJSk8Apy7oA31Gtd9p3m4TFkT+8UCE/iQ5EuJkKyTxRLri2TU1VJBgID9Rw3XLCHJqk3GI2ZUsTo8ug8uEca7jZ2wfEW7FahNVl2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej13FYXCJHaQ8g9ak43S1Qh5caJZj3zZ/C9k9rz8aKo=;
 b=hWD8YYGSKLGbaKIYmhYl3KV9ZdQyRtWdOc7AsK9Vt+arYBBGa5AhK6HI+leeDhuLaEeKVIcmKxD9cQ8+7TqiT5LQ/tWgillIXf/wn/0YzcztyIhQObLdbUgJ6l5CzMlpQ8WgmRAbg4pLR0sjYCtqIeoGsA8wdwi1Az2CpQ45b5M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5450.namprd10.prod.outlook.com
 (2603:10b6:510:ee::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Thu, 25 Aug
 2022 16:09:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 16:09:15 +0000
Date:   Thu, 25 Aug 2022 19:09:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     patrice.chotard@foss.st.com
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: stm32_qspi: Add transfer_one_message() spi callback
Message-ID: <Yweeol1yneu0FI+E@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0098.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c908124-13ec-42e7-4709-08da86b4284e
X-MS-TrafficTypeDiagnostic: PH0PR10MB5450:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1J9DpfNOzdD45KUEvII7OmshJJYvhGLRy1CouEfGB+SZ3+ZaqE8UmfFtj6HXVGRzNTLQH6SO+gsaovjj8NEc4QYvLjt/jRbsoajylEjYp4vUZ7X2P+E/YdXEMAofXInXKr08t+oQmxrR4dJhCvUzWyFiwbL7UwpiH9YjMyc/Fyv9FQVRwEkwve4pK4RtN8T9V2JJJEmTcZHJknE7fip64LfXkueVBgr50VL11ZREvHz2n5lgX4V6hXDzSn2bSEsKAmBFvDO2InSxCBd1WTb41JSclXlPie+G9oxSf6vAzTI/UbbFlIzJqQVus0RS2xQ49AJ3CsVGLHrkTao6QdxCHaumyaeenrQZ05AM6LcsKvBehOzQgeqpPMDUtQfk84D9PZWQUu2ft89H2XLYJ+UYuSHX4JcllHPfxqR0Pi8kPi9grTGW745grajRYNr4IsuJq6OVbhfkXg2tALo9lxawRe08e7b8sduA5BgmrWG4lyAvaw5eywowj52KzW8iUcAUQuwttnmCyP2DrjhxxN6+dMbtyiIJOQX39gsOe4Ty3E6cBCF7EuoIxGhqtgpl2tmN7dxYx7HJfTVhonHeL3M48+5x6FZOPLQK8wqcnIy1WePl36EIwdKYiP70tE/fAIwNIkD+8g8gnKoNbIjWddmcDzz1bklmQOqJTTia4bh1Gt1Hli1I5VpG1R8mN7AYp80JnYL+NrVRNkGvyUDoH/hSqtQrpRXHFUDb5T3tuJRjWQU0L9Sw6mZRjDI0WX9JUycRIj2kWTkKbucFV8ZXfahvlbGJzSE4iRTPwIs5rzYqryg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(39860400002)(346002)(136003)(376002)(44832011)(6666004)(41300700001)(6506007)(478600001)(186003)(26005)(83380400001)(52116002)(6486002)(9686003)(6512007)(2906002)(5660300002)(33716001)(316002)(66556008)(66476007)(66946007)(6916009)(8676002)(4326008)(38100700002)(38350700002)(86362001)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8n2/hjx6qRB23ysn9J1Yot6yhAzvTxDzHov455qSxRBaHL5s9GJxHOCczI+F?=
 =?us-ascii?Q?1HuwtzPsj1tJkmPxAEKE5XWH4TYKYZGWRhMm3iRKVkUTMI8gr1GqBOOyPwDp?=
 =?us-ascii?Q?s5TeHPDrLn+/WgEd7vkC+h8bqN2ZSJ7Z6pophjy75d2rQsy2YA7GFYM8X5q4?=
 =?us-ascii?Q?axFNzXTrhHreK8RP9MCsaPVTq7mulsfmIzYzdpGEuTtfKNrDbgFhGu96xdWL?=
 =?us-ascii?Q?suMHqQFb2P4E+6OBEK4lqH2UHyjtpCvqqsP3L/Irjb+R0T0cFYV1ZpNU2Hp6?=
 =?us-ascii?Q?Wu0Bor4S/wFGenWVkDrhgFoXrOuulHZKV2t+O/oOHjZ+BtjSgRlq9zzlxMGS?=
 =?us-ascii?Q?W2VAWwlfoUJcxlqLj5YiI0pmPWpQudPa1DxpbiKGgDd8RA3pGHgdPG+ZEPHb?=
 =?us-ascii?Q?A6XfBn4WSgP0EYQ3T7atj0Kim0qLt7jtMAN7pVsFyU0vCzhHH3LcyxAlo6ii?=
 =?us-ascii?Q?XlRedf1gVe6HeFk/4QRrI2CQvKsl9MWFj05mYGZO2bvOQTqqFHF3ezqiy05K?=
 =?us-ascii?Q?p4I7UQ08i8O9HND3yCS1MuKfy4If/kcJbwTL5Nn1TSNLesZKznKslyugD1d8?=
 =?us-ascii?Q?OK+WjNtraTz2kVJBx8+0sO/gzfxw+OsPsoG92QHM2yN6j9Hc6U/PTJQfkpTe?=
 =?us-ascii?Q?dW4dUtaRUrUD4YrBDd3qjqcqk3qOBcOBiAO7zIVDbVnbgMbrht40R86ldTqN?=
 =?us-ascii?Q?0/xB0xvA7dWOZNZFd19/yCfaFeMd0gjKBipQIntNMpBENGMrhrqIVCFV+di9?=
 =?us-ascii?Q?HWyYmRleob8uC0aqF7SJvU4Q3P4JmxMY+VysB0/vx3aXChm6u2c5PXBjarYd?=
 =?us-ascii?Q?98PeI8/Wxk4Y7IpiK1zVGKLzgpaMbePMJWmU3YZyI0CIB+I9PVARzKxX7ZvO?=
 =?us-ascii?Q?SpIPwYEiBC9DotD8S0UCmitLU4HPg53X+UYIFUnMDLM6/kVa0T4eWTAfN6ke?=
 =?us-ascii?Q?u38S0ERJIAytmBbMhNXipcxBZckPy8667klE78KkYqD1yM/oi5q3My++mkOk?=
 =?us-ascii?Q?X2Z9WQzc7ufszHByKbqwcBwFd0CmruFZxNhU92PiTiRjvDa1ZUwU4w5oMYuM?=
 =?us-ascii?Q?tVqA6C/jf12xxqnlX5nalYLwGGQRZgPiXexEDoYzT9yEVu4kQjet/r84lEsE?=
 =?us-ascii?Q?n6D723D9q0NxzrCf1+mq4w4AtclXyQ+aKETYlitl/qgXU9OIQREbw8hHRXX7?=
 =?us-ascii?Q?OmEcqnmcQ3wOTEaIpPC4SWzSR0TWeihTYwazldRmP16q5pxMdj+qIEkVPCOK?=
 =?us-ascii?Q?BvWqceW90x1WWFCh3gJ+Tt/we9utA9WwH5gcxhegzjaPNMAgJEG3BLS5RX4U?=
 =?us-ascii?Q?KhhM5OyO/7uQnDXXnKqoNDWWr9925tKPdrgKSUhBO9uE/YhIzAGH9edHYBv+?=
 =?us-ascii?Q?4bNvSI+qtcpAVM8r3zcbe9ijzktmkRWJvfyTsvNu3tbB8YxO0oGPbBcUnT7j?=
 =?us-ascii?Q?PJl0yVHOndNtEOkRGg33B/OVVdHXKSjajGQrYVtrSNjlJjjjsWMgZmooumtJ?=
 =?us-ascii?Q?c5qWDtN7B2idiDWfBUCxDm5AvBKqN+fmnVxcbYsYFavhM2tYP31jmih6Qhvp?=
 =?us-ascii?Q?SzO8Ea82V7Ov84GcJeYhZ3rvAMJ1b4OnxdHSLmJoNyra0FnMbWQvhPpMEFkK?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c908124-13ec-42e7-4709-08da86b4284e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 16:09:15.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PgyFpaXEZ7cppy0oe0+hc284eNuZVG1RJx8dmhdn7C5y4ZBxLmEejdIyjo/xprjMv3aEP0VjhKKK+MLA5W/QbFMRTnmjO7gcPhp+OUGd8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250061
X-Proofpoint-ORIG-GUID: QbqEB3-N1A756zszqHZ3dD6fLu4OBJkW
X-Proofpoint-GUID: QbqEB3-N1A756zszqHZ3dD6fLu4OBJkW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Patrice Chotard,

The patch a557fca630cc: "spi: stm32_qspi: Add transfer_one_message()
spi callback" from Aug 23, 2022, leads to the following Smatch static
checker warning:

	drivers/spi/spi-stm32-qspi.c:627 stm32_qspi_transfer_one_message()
	error: uninitialized symbol 'ret'.

drivers/spi/spi-stm32-qspi.c
    558 static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
    559                                            struct spi_message *msg)
    560 {
    561         struct stm32_qspi *qspi = spi_controller_get_devdata(ctrl);
    562         struct spi_transfer *transfer;
    563         struct spi_device *spi = msg->spi;
    564         struct spi_mem_op op;
    565         int ret;
    566 
    567         if (!spi->cs_gpiod)
    568                 return -EOPNOTSUPP;
    569 
    570         mutex_lock(&qspi->lock);
    571 
    572         gpiod_set_value_cansleep(spi->cs_gpiod, true);
    573 
    574         list_for_each_entry(transfer, &msg->transfers, transfer_list) {
    575                 u8 dummy_bytes = 0;
    576 
    577                 memset(&op, 0, sizeof(op));
    578 
    579                 dev_dbg(qspi->dev, "tx_buf:%p tx_nbits:%d rx_buf:%p rx_nbits:%d len:%d dummy_data:%d\n",
    580                         transfer->tx_buf, transfer->tx_nbits,
    581                         transfer->rx_buf, transfer->rx_nbits,
    582                         transfer->len, transfer->dummy_data);
    583 
    584                 /*
    585                  * QSPI hardware supports dummy bytes transfer.
    586                  * If current transfer is dummy byte, merge it with the next
    587                  * transfer in order to take into account QSPI block constraint
    588                  */
    589                 if (transfer->dummy_data) {
    590                         op.dummy.buswidth = transfer->tx_nbits;
    591                         op.dummy.nbytes = transfer->len;
    592                         dummy_bytes = transfer->len;
    593 
    594                         /* if happens, means that message is not correctly built */
    595                         if (list_is_last(&transfer->transfer_list, &msg->transfers))
    596                                 goto end_of_transfer;

The comments suggest this should be an error path.

    597 
    598                         transfer = list_next_entry(transfer, transfer_list);
    599                 }
    600 
    601                 op.data.nbytes = transfer->len;
    602 
    603                 if (transfer->rx_buf) {
    604                         qspi->fmode = CCR_FMODE_INDR;
    605                         op.data.buswidth = transfer->rx_nbits;
    606                         op.data.dir = SPI_MEM_DATA_IN;
    607                         op.data.buf.in = transfer->rx_buf;
    608                 } else {
    609                         qspi->fmode = CCR_FMODE_INDW;
    610                         op.data.buswidth = transfer->tx_nbits;
    611                         op.data.dir = SPI_MEM_DATA_OUT;
    612                         op.data.buf.out = transfer->tx_buf;
    613                 }
    614 
    615                 ret = stm32_qspi_send(spi, &op);
    616                 if (ret)
    617                         goto end_of_transfer;
    618 
    619                 msg->actual_length += transfer->len + dummy_bytes;
    620         }
    621 
    622 end_of_transfer:
    623         gpiod_set_value_cansleep(spi->cs_gpiod, false);
    624 
    625         mutex_unlock(&qspi->lock);
    626 
--> 627         msg->status = ret;
    628         spi_finalize_current_message(ctrl);
    629 
    630         return ret;
    631 }

regards,
dan carpenter
