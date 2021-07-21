Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0483D0E35
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 13:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhGULPK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 07:15:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32738 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237741AbhGUKwX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Jul 2021 06:52:23 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LBUsU9005424;
        Wed, 21 Jul 2021 11:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=HO8YJRvnO8Q6t1l6oUDCqmKyj1sIib34LMWjzceV2RI=;
 b=pqR8obmZeiI++bsefLDB+Xq+3/OKyNJkMr16Tu5f9xzxl3jC4k9KqWPPXZtSOH/MtdYX
 mArhujzJKlfI9Ygw5Rbw8ZCyXrkxAcWehbYdiq33k7pm/Yjc4LdD7wxTEvHX1aa0vpRT
 PiJVxfx0Kt3D+F562ktXxA5HfZAiIOdoz4SVnoFLVMUNAkW1UpPt8BibolmmO02YXf4R
 ggJxkfK1+El9XxMLgbWTKGsACvdf3mBmqPADuql9VtiUFiXYrWncxshmU50Wp0rnWYD6
 eRN/ACPkur3t0QbhJBWteuSLZ7+r7r+/18lJjZH5XI1QCpmFiQvIQZkfs1q0Kg4KMOdN WQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=HO8YJRvnO8Q6t1l6oUDCqmKyj1sIib34LMWjzceV2RI=;
 b=MrDj6K2a/g5iCmwHXXRRkJgQsgtV1d0khwjZG0YyttXpOKq0qmIYQ3Vq5dUXELqZJhmo
 ZYG8KvzN8BtIobQA1f9k7kR9vUg68ScZ2HdvQ+1wy8Gxz2X2D/VvRQdYNbCgP5HQZcM0
 AmaSTRRGKpSMnQZOvkLsYw31QuVNIfc/DrZg5TWrzAymlFIaenaOI9U5M5p6aQ66VPI5
 ImY8lD1iamvKQnlYKm+ht8U+VmcuJQMwnggYLSzuEBTjcZ+t51lO5iLmgfAnnoERdEo8
 xn+UmcHZDPI174W7XBUNxD5NP+L+rK2tc6pIDEGdEqg5s35cT905P6njR68EIodaVYHU 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39wyq0t8fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 11:32:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LBUQxE030983;
        Wed, 21 Jul 2021 11:32:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3020.oracle.com with ESMTP id 39v8yx7e2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 11:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAhl+ozgrizlxvuj8wG2RXGzu1l8+lqW7iJvskoc12u/mO4GkmELCOxU7GRD1Xxe0KeZu2k03Vi3p2yFD2HxxmC92zqz3+f4ta9J575LmuDUse9zcBcXV4dg47yBLY1T+3QfIzY3xqH2MZBYHdI+3zQyUych+d2LBYBicZr6ZsxTpLF7QSc2zawEUHKOZdyurk1maPpmbFIJS77cKSCigrITs4D8szn2B+bZdw3uQDHr1kavFIvVTH31XthTfqrhtRp+fZ7aglSJW+mwhf2uNOX6alftaPcrO2SE40ZjxTUO8Z7mYoLdYUP666BL+WdbXUjTwEGxkDX+rS5EhZrsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO8YJRvnO8Q6t1l6oUDCqmKyj1sIib34LMWjzceV2RI=;
 b=MmSzrmDlYZ6fYVpxQiGHZALWMZAbzjoYOk09aqywI1enWLR4D5L82kPKQBIXabqrmu++/BBElxdBev3g/JKgaXUvm7erYZ1qf9NDFWuz+xOWhttHiL7109hXW+fwOhy+8KxPNVhmD7bROJn35a7kb3zzy2VcAfHIh5Q0bxkgDYuaAbCN7dCNcSPbQRPuEiHcwgCLV0awVRX/Yaw3fkJoOPD4qUoBed+8e6aGKJX9iOV3PRlj1nODJ8AtXdNBitsgT/JuWOshTx0zTvxFlpk/sm8R+/qZloF3+7l7c0zkC9+3t4F6R2CBPE+y0JK4JVfih2sDULgnqspNUkPwyF9BYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO8YJRvnO8Q6t1l6oUDCqmKyj1sIib34LMWjzceV2RI=;
 b=pTNaT75lpuiRpLmF3sS+RROjo0uKPTCFxprnNt4NtZdY75J5Yg82SnoWk51kFaEfIBQbyYTz4kQNrX1TX8nf4o/O0slnnI25dx4Kk9OqJAWM9rrrICdTsbON65zAipEUpjqnh/XDUItT5nwl47BzoNwn0cK4qY0nNcBimuS87dg=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2255.namprd10.prod.outlook.com
 (2603:10b6:301:2f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Wed, 21 Jul
 2021 11:32:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 11:32:56 +0000
Date:   Wed, 21 Jul 2021 04:32:46 -0700
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: pxa2xx: Reuse int_stop_and_reset() in couple of
 places
Message-ID: <20210721113246.GA24694@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0067.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0067.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 11:32:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38b9a198-64ed-4ebf-d991-08d94c3b4892
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2255B264BA59574BA6CFCAEF8EE39@MWHPR1001MB2255.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +579Sp5aJQzKRo0J7Ko5X+A+7TpmQGN7Y1nmDpJq4wo5hTLKOWNeGM1FoAoZYkcRTNeiAzgGyiUk2RTvhSmVkPuALk3vh21n5iy/J0Ox0LBo34gxWiN4GhIjKbRnMiakNUYJhsjTMXjIMtlXno0o9BqgHG8LkxsgvrnkoNJ06QEjoeSHvLdgs7AU411qZbnQUMDyghho9Yf90jowSJ14wVY4TIVSRZQI8O3yWI2nEH+aCSRUHn9lU51DBV+p85ntQprjOX4BbGhv3j347rhwVMiDqy1gdbhIwounjPMMwmV/ZDVwhHTW3EK9HN7wlcT5K1HOxAFj3TTMi7obd+Yv4PtwQa95E3brQ6Rz+v+hNC/IJHxmIj5gHvBs/uXLSI08RCsebEDpHYskpNjMqw77VVw7t36HWIVxzY49t/Ux3pi0UzfYgP+0Q01u+4hdwjBAL+kC2W9nqD0r983Z8vA5g13tXUD9Y9pwypF5rWbhlPgip4gTlQQFHzbCENQVX1Mx5ze8+rGzdgs9HO05Roj9CtefL6orBH6T7C+0MBNtsd1DRElha9jVoY991Ztq0AE7lCci+8xp0Xe4POc84y9U8QCpTtc+ZC3tSMtQWN11W4wT4Q435DCnhg9YXpUg4KjNZr7h0Bt7d3FEO5tJjlycvLCAIAa95xC26rkPqHD+7Wc6kKy7HMXs4pYszcPay+zforE2eR0euzr2oSYcrorZjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39860400002)(136003)(366004)(26005)(2906002)(52116002)(83380400001)(478600001)(44832011)(6496006)(956004)(33656002)(86362001)(9686003)(9576002)(38350700002)(186003)(38100700002)(55016002)(4326008)(6666004)(8676002)(66476007)(66556008)(6916009)(66946007)(5660300002)(316002)(1076003)(33716001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5na5jAvdxHy2/EFvMs58urgmVY9+KzLE8PiOeJrw2GuGsrbeh94qNxkuTyNo?=
 =?us-ascii?Q?tJFRQyDTU3nZddOLHVKl9Z/6japNjpvB8MSGO6jFw3HTJOO837eH4MtcM9Gp?=
 =?us-ascii?Q?2iOhS11k7OLM/MjNayq6CIYPBhvUridrOTx1qGPYue6F+WZl12Vv7xbf/iis?=
 =?us-ascii?Q?LqAXTl2vZ808jdkh9qVfqOBx3xnjWLRym5G5wD1FN4Xbujc88ftt4Mfph11p?=
 =?us-ascii?Q?wBZD1UnK+JCIx0j0lfaPhMSdz/lr9MEVlKLiC++j5q/TEuKH2k7/on4NpzQU?=
 =?us-ascii?Q?n4uf1YUf2k3mhPxfVF8pQ/qinoi2OElRwOarzp5s2MkN3ZzsSK9Y6c1OFrR+?=
 =?us-ascii?Q?FgE1cYM3vvlUTKQd470kuYevqWGorhULpOZ0edIBsmgckPRl8ybwbnIi/eNU?=
 =?us-ascii?Q?6dRYpfGPJOamKXJE4tdTNViATdl8PDndWHhbRWEXuG9GoFX7db128KRcPR9J?=
 =?us-ascii?Q?mbdyNTnsJ0wHI9V9Ob56cBrUzaxWX8SZrk25UNMJ/CxqYdtLRN3ptQ9S7rTT?=
 =?us-ascii?Q?vmUJxPlxMSpLjQ0GeCoYhS24b/m9/d0aAiKS/Gam8Qgg1aVfa8Ms449JYwXC?=
 =?us-ascii?Q?AHqvnbAt7DU4pXWSnmGucB8OWTwrNSraT/8tOeFeBw5uLU9RYz8jeW1+uScI?=
 =?us-ascii?Q?0bPmPFs0vJl2su5FgBeNMEQ92b81RYpSCars+kQeLpe8srwYNCkHSV5RfKlS?=
 =?us-ascii?Q?WLpKV+uwYFvKs4Mu7l7yai8ck2z5t8ZEXgtwViGuUCgGoFAIuux+Wutlrac7?=
 =?us-ascii?Q?D7cw7k14APoRR08+nfcC9LZenGQ7QjyLWxjv94lLL4YDje2BtVTrY+s1rQ97?=
 =?us-ascii?Q?n2C+llzyCKS5YE0uHQB4R09iSSRC/CGhGqEv8CpkEpwYoSQCc0EbmJRgsayw?=
 =?us-ascii?Q?fsfP89bgxOqBm8dG6SqtVm5m9eeyPVvf2EwWpQa3f/kONuuzSiCWRhzUYIh6?=
 =?us-ascii?Q?k4cUFtyOfIPdOARY89YtXrzBJkdQyiAMn+c4v8eSOtkr0OmVzwmnxswdRbWU?=
 =?us-ascii?Q?QkCvxZQobvtqH5Hcz1Jd8muQqVi1si/rfPVZ281uBrG7jmuVrSP57wjsR5xU?=
 =?us-ascii?Q?q7yt6aMkMw2eSPbtKLGGlZiBUxI33TwnLSv/oIX0rUUBMnOTIP35yu38rvkm?=
 =?us-ascii?Q?aCv8GF6zNlDVoWp8qKPuBzUaQcEcG4Xw09fkib3DOZQLEhYU9S6FgHZLodx6?=
 =?us-ascii?Q?q+V3ep8/rxx7t4nzrT+F6eriFVVCNs8UHjWKOpAeNIuFFZ4mqQO1yX458BSR?=
 =?us-ascii?Q?pgwXZrsupKqfyn8mDRoEoQ+Gnnz8eHnOFX/9gYzXq7AjG4K/Magw1Iwb1kym?=
 =?us-ascii?Q?f0WsIBfihOHvrqZlyOGkjKS9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b9a198-64ed-4ebf-d991-08d94c3b4892
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 11:32:55.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rjAzx+lGTZ9ymR0Ug6lJh4wXuBdcGh1EHYud6+CdO1SoCqFHWqXmNcgk5WKCxlqnYNPr3dE9ZNaccA5159nshdQ5i2cxzPU5vMGXDFCHrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2255
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10051 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210065
X-Proofpoint-GUID: QSo1BYlUqmuM7XmA-UMWOLE_yBxpDnZo
X-Proofpoint-ORIG-GUID: QSo1BYlUqmuM7XmA-UMWOLE_yBxpDnZo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Andy Shevchenko,

The patch 3bbdc083262d: "spi: pxa2xx: Reuse int_stop_and_reset() in
couple of places" from Jul 19, 2021, leads to the following static
checker warning:

	drivers/spi/spi-pxa2xx.c:774 ssp_int()
	error: we previously assumed 'drv_data->controller->cur_msg' could be null (see line 773)

drivers/spi/spi-pxa2xx.c
    731 static irqreturn_t ssp_int(int irq, void *dev_id)
    732 {
    733 	struct driver_data *drv_data = dev_id;
    734 	u32 sccr1_reg;
    735 	u32 mask = drv_data->mask_sr;
    736 	u32 status;
    737 
    738 	/*
    739 	 * The IRQ might be shared with other peripherals so we must first
    740 	 * check that are we RPM suspended or not. If we are we assume that
    741 	 * the IRQ was not for us (we shouldn't be RPM suspended when the
    742 	 * interrupt is enabled).
    743 	 */
    744 	if (pm_runtime_suspended(drv_data->ssp->dev))
    745 		return IRQ_NONE;
    746 
    747 	/*
    748 	 * If the device is not yet in RPM suspended state and we get an
    749 	 * interrupt that is meant for another device, check if status bits
    750 	 * are all set to one. That means that the device is already
    751 	 * powered off.
    752 	 */
    753 	status = pxa2xx_spi_read(drv_data, SSSR);
    754 	if (status == ~0)
    755 		return IRQ_NONE;
    756 
    757 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
    758 
    759 	/* Ignore possible writes if we don't need to write */
    760 	if (!(sccr1_reg & SSCR1_TIE))
    761 		mask &= ~SSSR_TFS;
    762 
    763 	/* Ignore RX timeout interrupt if it is disabled */
    764 	if (!(sccr1_reg & SSCR1_TINTE))
    765 		mask &= ~SSSR_TINT;
    766 
    767 	if (!(status & mask))
    768 		return IRQ_NONE;
    769 
    770 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
    771 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
    772 
    773 	if (!drv_data->controller->cur_msg) {
--> 774 		handle_bad_msg(drv_data);
                        ^^^^^^^^^^^^^^^^^^^^^^^^
We can't reset with a NULL drv_data->controller->cur_msg.

    775 		/* Never fail */
    776 		return IRQ_HANDLED;
    777 	}
    778 
    779 	return drv_data->transfer_handler(drv_data);
    780 }

regards,
dan carpenter
