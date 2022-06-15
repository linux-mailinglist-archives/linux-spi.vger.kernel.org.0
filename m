Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4606654C320
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 10:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiFOIJr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 04:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiFOIJq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 04:09:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671BE1C90F
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 01:09:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F6uNfY015214;
        Wed, 15 Jun 2022 08:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=lov3XXuXI7VYh6vpEQUJhU95nxvj+ZSqhFn8gF8gNKg=;
 b=Y/F7BFmDXCRI9G+IVKweCJLP7Iu0PogBRGcCqyygDjc0ADRkJS0aEk1vqhrRPTwEQk6J
 TikViKKeepPATvgC4X1NeieD+wmdgtGo4stt9qkjhglfRDbRtA6EVKMWMd/p3vn1g4AU
 XsYzaxPpW1D+/kZv52tLf5emRyMZQRXGPihZZylES0TfCEhw65h6LjLA3KnMi8GK00zK
 rE3bpdHR9sZzQnUzIvMXGmgSAP+j6AeccEzgukrh5UiSQ2hGrdQSJ9RMxnvDv2/6XRZI
 aqkWhWSj3obTocTW2SSKmVCehYyI/OkRFw/6SkUz+0iZ8M6tuHubQbXYdgtwJJEshjLm eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0fx37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 08:09:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F80DF8024217;
        Wed, 15 Jun 2022 08:09:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr2a0376-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 08:09:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD9OdoHAEf3BkjdJoBDE5db8EYYCmjti8JFB6GSdXF58KVZDioNmxd0UPhtmqBVpu4hJXHNugip+mym6Digd8oBi692xIF1NwWozUMXkxyfmw0JRKlp3vNpGGotBH2GRwxppQPm1slzWlYSYfzAMgv9ABQu8DVTqHczrINeLpe3a0yu2Gu9KlbZqoP0McSYll37iVguf5F/NLAZIQVut6DEMex7IdNB06WoaQbzXQArvh5bRTeY7/xWt+6Wyz7bqOy2J12HSDQks/Y/iiglI3v3IMmhJwdUi3H0e7BIvSMnrhj+BjEt9fnB3jNj0BMS6HQDXIXNGFlWnZrR0Nb4niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lov3XXuXI7VYh6vpEQUJhU95nxvj+ZSqhFn8gF8gNKg=;
 b=ZpS10WAhb0sAZsQdM81qOC31vhH+eSu9c7B2lU/vAns26rz/6flbYXwwzqV7njSTndOkmLwAUiyt9MYLfY/Fbo6Gs++zH53LS5Y3/gMY68XpwYwPE/mwaeUBi7cbB/rW0XZjIaIBlyB+VJVJzbw7fTl8Rz5qAm+nrzjWB7NGPMjpQgpsyINlDDgAaMk8Kid4ye9BffPfzVEEGEnBhsYqIGQ8dmSEytcpUr3Z3CNM+PUopkip5g+q1F021rf1k4sDHlvS9t+GnPaBn+X5I1pYDYjSVSuk/ikBvGlNHgEBngveDNGaH/2NwCYTe5AFcdYbDwn0Ntm/612OVtWMYj11AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lov3XXuXI7VYh6vpEQUJhU95nxvj+ZSqhFn8gF8gNKg=;
 b=RHugD15j/4/WWKGf/+bCfpLAQNBXaCWRV6Oz414QcCJJ2ECNOlm96jXPYH270IvKKu7wcC3YfNlVi9a4B98wKRCJO3IpDlutzqknqpFGmzXZkDnJqz4KYb20CpofN+iHfBJz63v0y47qK2SnOEnD0kENpfROQ8LneIo6rNn33n0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2264.namprd10.prod.outlook.com
 (2603:10b6:910:43::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Wed, 15 Jun
 2022 08:09:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 08:09:41 +0000
Date:   Wed, 15 Jun 2022 11:09:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     conor.dooley@microchip.com
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: add support for microchip fpga spi controllers
Message-ID: <YqmTuWEPKkIH7cBs@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0170.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7865499-69c7-49fc-d9ae-08da4ea665f7
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2264:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB226437CD809F5E29584AB1A68EAD9@CY4PR1001MB2264.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2/+Bywej8qZKQtphqVVlgVJgQlwYDo+OfRbAR2ow8ksai5Q7BtF9GowBwqsav/xfEemgt5iRPfSRgbSjf80ZdL+OsWEHUm4pnyXntmZJ5Tp8nxjECLHxboTnCoNMBZibfsdoIAfYeVrSJEFFTQSM+PFmqQS/pl87S0QYPP962hnV1DNoPbKLif408EQ/3iJM+yg3cKM7XxZOVIIkaZPX0MwdBOQ9MoDqiYKJ0JzFcvdpnX6ylqJ7EBJ/Grc3HONY4wINuLtp/zxg9c5CboTFgvT5/cP6FQyPD0N3VYcMXLOwAJdqp/5QVCV1/jNXjeLOBqR5C1OVll4APFv6kYI0auN5oAMGRTv3uQbhnhLKPv2NQ7BRB/fsA0My6aRDSMbONESS+vhOdCZm4UqEvI8wS5KN9olNZXTBQ3BTXHP887MN9SeGaip8z+NMSjE0gHRzfFwGmgY8wMMmTo1D9kwOZE302VYA53+Y4omyzDmR07QOL4cJ9xkQPKbhioAnyGygIZxLKHdRfs7yGJKsTvfE61Y/G1Pg1JClmob9afSwSc96VXTolFo4lVE1bQW8T6AzzhL6cU+zawiOnlm8XccYsP+7SsUBo+T34/FjS1wcONDY/uQ3fTgChAS78qL0CWXahVHBzAS/kAE/0BoCpu8xQ83OlCS25R2BsR81j+MbjyCfvetaH5zrNLXl2zwSfMVoMllK/04kPC8rmO3uA9Wyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(8676002)(33716001)(86362001)(66556008)(5660300002)(44832011)(4326008)(38350700002)(66476007)(6916009)(66946007)(8936002)(6486002)(2906002)(316002)(186003)(6512007)(508600001)(52116002)(6666004)(38100700002)(6506007)(9686003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cD8Z7y6IUjSphV5WvUxlsOEP+9tZJcWKZvLpDx9JDuPpW5jgIu+aUnmlEG+g?=
 =?us-ascii?Q?i2yVym2vM9OZ9Vsfv4W2OqG4znuUTKV2lOgW+HeV6tiO2q0gMUDTS9N2lnxk?=
 =?us-ascii?Q?W+1+VjrEaKWHFKfgxa5ZkFEa/Z9VG51V6myryAgGXuH0dl3cHQZ6ncqNBEub?=
 =?us-ascii?Q?iNemGIFD/ywfQutCx3KbBvDJGU9DMwKhikL49//MixQxO2LUIwx9y+YkuBhe?=
 =?us-ascii?Q?XGD/Dc11v2J9vEh4ENgV0Xab9oiL8wkTXyyy7hSHFVQYtkHZhj6IZ2Ie7yiY?=
 =?us-ascii?Q?pFs2Gag/r2vO+y4dNbyckubyM4c7j4uX2YgY2enrn/CdEQo7uiO6ghLb2bFJ?=
 =?us-ascii?Q?NaVWLryQGM2lv/ywffjuWhlXjeyfgRbUE3qVSSFDd+oczAcR9ElHnKWFkTU8?=
 =?us-ascii?Q?p5fgAy2Lp/ZXR7/DwL8+pHFpaN85gfKGqj0+v6ZxEcK64JpWKCwBGKisu5I5?=
 =?us-ascii?Q?yiIdtcJDoLW1KbVOB2onFTqZKxGnJeTNckDwWA+w/aAs4BL9g77lalLWmo7W?=
 =?us-ascii?Q?HQ080qEpQA/6BVZ2qimwRulUL75sik+8gixeVF0d4Y2LntmMFe0tv9Azf3q+?=
 =?us-ascii?Q?lPSoSIhdBJqCAlsRIJYSDDCICmdUPYoOBZETcXI2P1k+MAzOTGIhnD8ZCDmB?=
 =?us-ascii?Q?J4Rk2QgLUY1I4jUEn73QOQ9WyVvGXfbZfC+BL6qW9w0x0S39rigvP6SBuqae?=
 =?us-ascii?Q?gBNrs+lpw9U+e8Dj60wNd6HNTrZX5G1kD5MuZz1/XOhfzf4+/4WI+BfwYK43?=
 =?us-ascii?Q?ZQffKvdO92OhStboFy8OyanzXgavJMefsm5c2EEKbc+c3M6BAEl3mcJz5LIO?=
 =?us-ascii?Q?9oB8K+wvzFkVMQquY+LpE/UV+J17rtQB0GESn8KWsdG7DN7fUhSn8eJ2Bmgt?=
 =?us-ascii?Q?W3ZB2LA6dZ9Ngp/KSoTkaeYLh21qnfogxE8+2e2+gZNPFVR6vOwZVoCSR35/?=
 =?us-ascii?Q?KCLk7o/5tdc7Im+2Mfw+g6YPluKhybE6Z3w/lhio/TSOAw+yKxKpqCFTNQ5x?=
 =?us-ascii?Q?8zXs9REosQVDSCasB/PMSydXqXz2+EzJ+qYgr488pBv/VfVT1WJmFenDa4t7?=
 =?us-ascii?Q?jzky4QWZwhUvWS7cCBy391bRdxbUWNY+Qo3Tuh74yxoixzm0Z68wJ/vvGfSw?=
 =?us-ascii?Q?VfCTNPgStpw2lGAcP1NfjgOaRPrGhhISQBundiT00C/pApddOuqy/55erMSq?=
 =?us-ascii?Q?ahEgYlYKg3JeJQ5Obm65lhkCAXG5q2EBo6jvwSytz+cr2+ZWWq1TfR+8/gpK?=
 =?us-ascii?Q?XJeQ9c6IRe4s3pk9Ounqk/V7Am7FHOr0ho/gb6fWBdNrjF/0pWfdQULCMhDK?=
 =?us-ascii?Q?K3VkF0Kd5LUE3n3tUJ5Xtk0SIsuIirhwZ1elgoApgDEMfH1anZ/IueRNHl1c?=
 =?us-ascii?Q?U9pCZ2zRJakc36dfEyeDs2wT3e3tYsuOXeijwI95UeBqpp+f/wh4PmVu+bwJ?=
 =?us-ascii?Q?ANzD6lArT9eRy3E7VNm3GPGDKYxa8W6tdr46BmHmV4U0BB0Ghh+KYY+Fc0vW?=
 =?us-ascii?Q?S6L4TNRu5kSiysapYfJXWo0P6vt49ivkNjsoHhAh/J35wM5OMbw0NMKGmHJ2?=
 =?us-ascii?Q?Ex9Gi88ZjL6+OqiSe3bXumkn4aMEkd/AR6yuLB+v38u+QW9ayN9desg5HGe1?=
 =?us-ascii?Q?CpxYZdmOztfgUS/D/8GJ9/y+pFY6sH47+buN++XxsPiILj+KkXU8g+D/XeOL?=
 =?us-ascii?Q?8rSdaqeIrR3Na/1CpJFFIucXImQudvlt3/Y0FZi4szxCarRKUCHUeulW9inx?=
 =?us-ascii?Q?K/hDyoSvVF1OIKdLhDQoVVSfdPG+qT8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7865499-69c7-49fc-d9ae-08da4ea665f7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 08:09:41.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0stSXf8E64qrZw4JABZ7yu24xlpmPBEDGJEKdQFMvdOunUAm1JnjigA6UPs8GbHgeE3fadX/iKngIZ0af8eoGOAjMup20icM/+sEpnlZrh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2264
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_03:2022-06-13,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=397 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150029
X-Proofpoint-GUID: 4hDHt8IUos0zVerMZQ9arUZ3G84EyrZN
X-Proofpoint-ORIG-GUID: 4hDHt8IUos0zVerMZQ9arUZ3G84EyrZN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Conor Dooley,

The patch 9ac8d17694b6: "spi: add support for microchip fpga spi
controllers" from Jun 7, 2022, leads to the following Smatch static
checker warning:

	drivers/spi/spi-microchip-core.c:557 mchp_corespi_probe()
	warn: passing zero to 'PTR_ERR'

drivers/spi/spi-microchip-core.c
    506 static int mchp_corespi_probe(struct platform_device *pdev)
    507 {
    508         struct spi_master *master;
    509         struct mchp_corespi *spi;
    510         struct resource *res;
    511         u32 num_cs;
    512         int ret = 0;
    513 
    514         master = spi_alloc_master(&pdev->dev, sizeof(*spi));
    515         if (!master)
    516                 return dev_err_probe(&pdev->dev, -ENOMEM,
    517                                      "unable to allocate master for SPI controller\n");
    518 
    519         platform_set_drvdata(pdev, master);
    520 
    521         if (of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs))
    522                 num_cs = MAX_CS;
    523 
    524         master->num_chipselect = num_cs;
    525         master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
    526         master->setup = mchp_corespi_setup;
    527         master->bits_per_word_mask = SPI_BPW_MASK(8);
    528         master->transfer_one = mchp_corespi_transfer_one;
    529         master->prepare_message = mchp_corespi_prepare_message;
    530         master->set_cs = mchp_corespi_set_cs;
    531         master->dev.of_node = pdev->dev.of_node;
    532 
    533         spi = spi_master_get_devdata(master);
    534 
    535         spi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
    536         if (IS_ERR(spi->regs)) {
    537                 ret = PTR_ERR(spi->regs);
    538                 goto error_release_master;
    539         }
    540 
    541         spi->irq = platform_get_irq(pdev, 0);
    542         if (spi->irq <= 0) {
    543                 dev_err(&pdev->dev, "invalid IRQ %d for SPI controller\n", spi->irq);
    544                 ret = spi->irq;
    545                 goto error_release_master;
    546         }
    547 
    548         ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
    549                                IRQF_SHARED, dev_name(&pdev->dev), master);
    550         if (ret) {
    551                 dev_err(&pdev->dev, "could not request irq: %d\n", ret);
    552                 goto error_release_master;
    553         }
    554 
    555         spi->clk = devm_clk_get(&pdev->dev, NULL);
    556         if (!spi->clk || IS_ERR(spi->clk)) {
                     ^^^^^^^^
NULL

--> 557                 ret = PTR_ERR(spi->clk);

ret is 0/success.

Normally when functions like this return NULL, you're supposed to just
accept the NULL and add tests for it to avoid NULL related bugs.  In
this driver if spi->clk is NULL then it leads to spi_hz == 0 which leads
to a divide by zero bug.  So it's not clear which way to go on this?
Fix the error code or add more checks for NULL?

    558                 dev_err(&pdev->dev, "could not get clk: %d\n", ret);
    559                 goto error_release_master;
    560         }
    561 
    562         ret = clk_prepare_enable(spi->clk);
    563         if (ret) {
    564                 dev_err(&pdev->dev, "failed to enable clock\n");
    565                 goto error_release_master;
    566         }
    567 
    568         mchp_corespi_init(master, spi);
    569 
    570         ret = devm_spi_register_master(&pdev->dev, master);
    571         if (ret) {
    572                 dev_err(&pdev->dev,
    573                         "unable to register master for SPI controller\n");
    574                 goto error_release_hardware;
    575         }
    576 
    577         dev_info(&pdev->dev, "Registered SPI controller %d\n", master->bus_num);
    578 
    579         return 0;
    580 
    581 error_release_hardware:
    582         mchp_corespi_disable(spi);
    583         clk_disable_unprepare(spi->clk);
    584 error_release_master:
    585         spi_master_put(master);
    586 
    587         return ret;
    588 }

regards,
dan carpenter
